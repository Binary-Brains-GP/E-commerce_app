class CartItem {
  final String name;
  final String size;
  final double price;
  int quantity;
  // final String image;

  CartItem(
      {required this.name,
        required this.size,
        required this.price,
        required this.quantity});
}
