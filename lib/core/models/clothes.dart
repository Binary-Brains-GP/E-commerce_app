import 'package:mobileproject/core/helpers/asset_utils.dart';

enum Category {
  men,
  women,
  kids,
}

class Clothes {
  final String uID;
  final String name;
  final String description;
  final double price;
  final String? imagePath;
  int quantity;
  int? sellQuantity;
  int cartQuantity;
  String category;
  String size = "small";
  String? feedback;
  double? rate;
  String? status;

  Clothes({
    required this.uID,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    this.sellQuantity,
    this.feedback,
    this.rate,
    this.status,
    this.cartQuantity = 0,
    this.imagePath,
  });

  Clothes copyWith({
    String? id,
    String? name,
    double? price,
    String? imageUrl,
    String? category,
    required String description,
    required int quantity,
  }) {
    return Clothes(
      uID: id ?? uID,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description,
      quantity: quantity,
      category: category ?? this.category,
    );
  }

  // Convert a Firestore document to a Product
  static Future<Clothes> fromFirestoreAsync(
      Map<String, dynamic> doc, String docId, String category) async {
    final imageName = doc['name'] ?? 'default_image';
    final imagePath = 'assets/images/$imageName.jpg';

    final imageExistsInAssets = await imageExists(imagePath);

    final resolvedImagePath =
        imageExistsInAssets ? imagePath : 'assets/images/default_image.jpg';

    return Clothes(
      uID: docId,
      name: doc['name'] ?? '',
      description: doc['description'] ?? '',
      price: double.tryParse(doc['price'].toString()) ?? 0.0,
      imagePath: resolvedImagePath,
      quantity: doc['quantity'] ?? 0,
      category: category,
    );
  }
}
