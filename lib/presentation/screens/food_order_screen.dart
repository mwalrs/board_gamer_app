import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/food_order.dart';
import '../../domain/entities/food_order_item.dart';
import '../../domain/entities/restaurant.dart';
import '../../themes/colors.dart';
import '../widgets/food/order_item_form_card.dart';
import '../widgets/food/order_total_summary_card.dart';

class _OrderItemControllers {
  final TextEditingController dish;
  final TextEditingController price;
  final TextEditingController note;

  _OrderItemControllers({
    String dishText = '',
    String priceText = '',
    String noteText = '',
  })  : dish = TextEditingController(text: dishText),
        price = TextEditingController(text: priceText),
        note = TextEditingController(text: noteText);

  void dispose() {
    dish.dispose();
    price.dispose();
    note.dispose();
  }
}

class FoodOrderScreen extends StatefulWidget {
  static const int maxItems = 5;

  final String eventId;
  final String currentUserId;
  final String currentUserName;
  final String hostName;
  final Restaurant? restaurant;
  final String foodStatus;
  final FoodOrder? initialOrder;
  final Future<void> Function(FoodOrder order)? onSaveOrder;
  final Future<void> Function(String url)? onOpenMenuUrl;

  const FoodOrderScreen({
    super.key,
    required this.eventId,
    required this.currentUserId,
    required this.currentUserName,
    required this.hostName,
    this.restaurant,
    this.foodStatus = 'in_progress',
    this.initialOrder,
    this.onSaveOrder,
    this.onOpenMenuUrl,
  });

  @override
  State<FoodOrderScreen> createState() => _FoodOrderScreenState();
}

class _FoodOrderScreenState extends State<FoodOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<_OrderItemControllers> _itemControllers = [];
  bool _isSaving = false;

  bool get _isOrderEditable => widget.foodStatus == 'in_progress';

  @override
  void initState() {
    super.initState();
    final existingItems = widget.initialOrder?.items ?? [];
    for (final item in existingItems.take(FoodOrderScreen.maxItems)) {
      _itemControllers.add(
        _OrderItemControllers(
          dishText: item.dish,
          priceText: item.price.toStringAsFixed(2).replaceAll('.', ','),
          noteText: item.note,
        ),
      );
    }
  }

  @override
  void dispose() {
    for (final controllerGroup in _itemControllers) {
      controllerGroup.dispose();
    }
    super.dispose();
  }

  double _parsePrice(String rawText) {
    final normalized = rawText.trim().replaceAll(',', '.');
    final parsed = double.tryParse(normalized);
    if (parsed == null || parsed < 0) return 0.0;
    return parsed;
  }

  double get _liveTotalPrice {
    double sum = 0.0;
    for (final group in _itemControllers) {
      sum += _parsePrice(group.price.text);
    }
    return sum;
  }

  void _addItem() {
    if (!_isOrderEditable || _itemControllers.length >= FoodOrderScreen.maxItems) {
      return;
    }
    setState(() {
      _itemControllers.add(_OrderItemControllers());
    });
  }

  void _removeItem(int index) {
    if (!_isOrderEditable || index < 0 || index >= _itemControllers.length) {
      return;
    }
    setState(() {
      final removed = _itemControllers.removeAt(index);
      removed.dispose();
    });
  }

  Future<void> _openMenu() async {
    final menuUrl = widget.restaurant?.menu.trim() ?? '';
    if (menuUrl.isEmpty) return;

    if (widget.onOpenMenuUrl != null) {
      await widget.onOpenMenuUrl!(menuUrl);
      return;
    }

    final uri = Uri.tryParse(menuUrl);
    if (uri != null) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _onSavePressed() async {
    if (_isSaving || !_isOrderEditable) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final items = _itemControllers.map((group) {
      return FoodOrderItem(
        dish: group.dish.text.trim(),
        price: _parsePrice(group.price.text),
        note: group.note.text.trim(),
      );
    }).toList();

    final order = FoodOrder(
      id: widget.currentUserId,
      userName: widget.currentUserName,
      items: items,
      totalPrice: _liveTotalPrice,
    );

    setState(() => _isSaving = true);
    try {
      if (widget.onSaveOrder != null) {
        await widget.onSaveOrder!(order);
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            items.isEmpty
                ? 'Bestellung (0 Artikel) gespeichert.'
                : 'Bestellung mit ${items.length} ${items.length == 1 ? 'Artikel' : 'Artikeln'} gespeichert.',
          ),
        ),
      );
      Navigator.of(context).pop(order);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fehler beim Speichern der Bestellung. Bitte erneut versuchen.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final restaurantName = widget.restaurant?.name ?? 'Noch kein Restaurant festgelegt';
    final hasMenuUrl = (widget.restaurant?.menu.trim().isNotEmpty ?? false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          'Eigene Bestellung',
          style: textTheme.labelMedium,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // Status Note if the Order Phase Is Not Active
                  if (!_isOrderEditable)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Card(
                        color: BoardGameColors.accent100,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: BoardGameColors.accent700,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  widget.foodStatus == 'completed'
                                      ? 'Die Bestellung wurde vom Host bereits abgeschlossen. Änderungen sind nicht mehr möglich.'
                                      : 'Der Host hat noch kein Restaurant freigegeben.',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: BoardGameColors.accent800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  // Restaurant info card with menu link
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gewähltes Restaurant',
                            style: textTheme.bodyMedium?.copyWith(
                              color: BoardGameColors.muted,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            restaurantName,
                            style: textTheme.labelMedium,
                          ),
                          if (hasMenuUrl) ...[
                            const Divider(height: 24),
                            OutlinedButton.icon(
                              onPressed: _openMenu,
                              icon: const Icon(Icons.open_in_new, size: 18),
                              label: const Text('Speisekarte öffnen'),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Section heading & note when there are 0 items
                  Text(
                    'Deine Artikel (${_itemControllers.length}/${FoodOrderScreen.maxItems})',
                    style: textTheme.labelMedium,
                  ),
                  const SizedBox(height: 8),

                  if (_itemControllers.isEmpty)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Du hast aktuell keine Artikel eingetragen. Füge bis zu 5 Gerichte hinzu oder speichere 0 Artikel, falls du nichts mitbestellen möchtest.',
                          style: textTheme.bodyMedium?.copyWith(
                            color: BoardGameColors.muted,
                          ),
                        ),
                      ),
                    ),

                  // Dynamic Item List (0 to 5 items)
                  ...List.generate(_itemControllers.length, (index) {
                    final controllers = _itemControllers[index];
                    return OrderItemFormCard(
                      index: index,
                      dishController: controllers.dish,
                      priceController: controllers.price,
                      noteController: controllers.note,
                      enabled: _isOrderEditable && !_isSaving,
                      onRemove: () => _removeItem(index),
                      onChanged: () => setState(() {}),
                    );
                  }),

                  // Button to add more items (up to 5)
                  if (_isOrderEditable) ...[
                    const SizedBox(height: 4),
                    OutlinedButton.icon(
                      onPressed: (!_isSaving &&
                          _itemControllers.length < FoodOrderScreen.maxItems)
                          ? _addItem
                          : null,
                      icon: const Icon(Icons.add),
                      label: Text(
                        _itemControllers.isEmpty
                            ? 'Artikel hinzufügen (0/${FoodOrderScreen.maxItems})'
                            : 'Weiteren Artikel hinzufügen (${_itemControllers.length}/${FoodOrderScreen.maxItems})',
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),

                  // Live price calculation
                  OrderTotalSummaryCard(
                    itemCount: _itemControllers.length,
                    totalPrice: _liveTotalPrice,
                    hostName: widget.hostName,
                  ),
                ],
              ),
            ),
          ),

          // Fixed save button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (_isOrderEditable && !_isSaving)
                      ? _onSavePressed
                      : null,
                  child: _isSaving
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Text('Bestellung speichern'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}