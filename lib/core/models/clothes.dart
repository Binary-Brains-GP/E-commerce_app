enum Category {
  men,
  women,
  kids,
}

class Clothes {
  final String name;
  final String description;
  final double price;
  final String? imagePath;
  int quantity;
  int cartQuantity;
  Category category;
  String size = "small";

  Clothes({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    this.cartQuantity = 0,
    this.category = Category.men,
    this.imagePath,
  });

  // Convert a Firestore document to a Product
  factory Clothes.fromFirestore(Map<String, dynamic> doc) {
    return Clothes(
      name: doc['name'],
      description: doc['description'],
      price: double.tryParse(doc['price'].toString()) ?? 0.0,
      imagePath: 'assets/images/${doc['name'] ?? 'default_image'}.jpg',
      quantity: doc['quantity'],
    );
  }

  // Convert a Product to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imagePath': imagePath,
      'quantity': quantity,
    };
  }
}
