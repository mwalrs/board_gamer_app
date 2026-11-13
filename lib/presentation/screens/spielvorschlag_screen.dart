import 'package:flutter/material.dart';
import '../widgets/spielauswahl/termin_hinweis_box.dart';

class SpielvorschlagScreen extends StatefulWidget {
  const SpielvorschlagScreen({super.key});

  @override
  State<SpielvorschlagScreen> createState() => _SpielvorschlagScreenState();
}

class _SpielvorschlagScreenState extends State<SpielvorschlagScreen> {
  final _controller = TextEditingController();
  String? _fehler;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _speichern() {
    final name = _controller.text.trim();
    if (name.isEmpty) {
      setState(() => _fehler = 'Bitte einen Spielnamen eingeben');
      return;
    }
    setState(() => _fehler = null);
    // Später: Vorschlag in Firebase speichern.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Vorschlag „$name“ gespeichert')),
    );
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        toolbarHeight: 76,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Spielvorschlag',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TerminHinweisBox(),
                  const SizedBox(height: 18),
                  const Text('Welches Spiel möchtest du vorschlagen?',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  const Text('Jede:r kann bis zu 2 Spiele vorschlagen',
                      style:
                      TextStyle(fontSize: 15, color: Color(0xFF5B6075))),
                  const SizedBox(height: 8),
                  const Text(
                      'Die Abstimmung startet 2 Tage vor dem Spieltermin '
                          'oder sobald alle ihren Vorschlag abgegeben haben.',
                      style:
                      TextStyle(fontSize: 15, color: Color(0xFF5B6075))),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _controller,
                    style: const TextStyle(fontSize: 17),
                    decoration: InputDecoration(
                      hintText: 'Spielevorschlag (max. 2)',
                      hintStyle: const TextStyle(color: Color(0xFF777785)),
                      errorText: _fehler,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFDCDEE6)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                            color: Color(0xFFDCDEE6), width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            child: SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: _speichern,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8960A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(29)),
                ),
                child: const Text('Vorschlag speichern',
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}