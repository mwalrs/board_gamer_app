class FoodOrderItem {
  final String dish;
  final double price;
  final String note;

  const FoodOrderItem({
    required this.dish,
    required this.price,
    this.note = '',
  });
}