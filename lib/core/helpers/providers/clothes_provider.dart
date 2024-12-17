import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileproject/core/models/clothes.dart';

class ClothesProvider extends StateNotifier<AsyncValue<List<Clothes>>> {
  ClothesProvider() : super(const AsyncValue.loading());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> getClothes(String collection) async {
    try {
      // Fetch data from Firestore
      final snapshot = await _firestore.collection(collection).get();
      final clothesList = await Future.wait(snapshot.docs.map((doc) async {
        return await Clothes.fromFirestoreAsync(doc.data(), doc.id, collection);
      }));
      state = AsyncValue.data(clothesList); // Update state with the data
    } catch (e, StackTrace) {
      state = AsyncValue.error(
          e, StackTrace); // If there's an error, update state with the error
    }
  }

  Future<void> getAllProducts() async {
    try {
      state = const AsyncValue.loading();

      final categories = ['men', 'women', 'kids'];
      List<Clothes> allProducts = [];

      for (String category in categories) {
        final snapshot = await _firestore.collection(category).get();
        final categoryProducts =
            await Future.wait(snapshot.docs.map((doc) async {
          return await Clothes.fromFirestoreAsync(doc.data(), doc.id, category);
        }));

        allProducts.addAll(categoryProducts);
      }

      state = AsyncValue.data(allProducts); // Update state with all products
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace); // Handle errors
    }
  }

  Future<void> addProduct(String category, Clothes newCloth) async {
    try {
      // Add new product to Firestore
      final docRef = await _firestore.collection(category).add({
        'name': newCloth.name,
        'price': newCloth.price,
        'description': "Deafult Description...",
        'quantity': newCloth.quantity,
        // Add other fields as needed
      });

      // Update the state with the new product added
      final List<Clothes> updatedList = [
        ...(state.value ?? []),
        newCloth.copyWith(
          id: docRef.id,
          category: category,
          name: newCloth.name,
          description: newCloth.description!,
          price: newCloth.price,
          quantity: newCloth.quantity,
        )
      ];
      state = AsyncValue.data(updatedList);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace); // Handle errors
    }
  }

  /// Edit fields of an existing product in a specific collection
  Future<void> editProduct(
    String category,
    String documentId, {
    String? name,
    double? price,
    int? quantity,
    String? description,
  }) async {
    try {
      // Create a map of fields to update
      Map<String, dynamic> updatedFields = {};

      if (name != null) updatedFields['name'] = name;
      if (price != null) updatedFields['price'] = price;
      if (description != null) updatedFields['description'] = description;
      if (quantity != null) updatedFields['quantity'] = quantity;

      if (updatedFields.isNotEmpty) {
        // Update the document in Firestore
        await _firestore
            .collection(category)
            .doc(documentId)
            .update(updatedFields);

        // Update the state to reflect the changes locally
        final updatedList = state.value?.map((cloth) {
          if (cloth.uID == documentId) {
            return cloth.copyWith(
              name: name ?? cloth.name,
              price: price ?? cloth.price,
              description: description ?? cloth.description!,
              quantity: quantity ?? cloth.quantity,
            );
          }
          return cloth;
        }).toList();

        state = AsyncValue.data(updatedList ?? []);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace); // Handle errors
    }
  }

  Future<void> fetchSingleCloth(String uid, String category) async {
    try {
      // Set the state to loading while fetching the data
      state = const AsyncValue.loading();

      // Fetch the document from Firestore
      final docSnapshot = await _firestore.collection(category).doc(uid).get();

      if (docSnapshot.exists) {
        // Parse the document into a Clothes object
        final singleCloth = await Clothes.fromFirestoreAsync(
          docSnapshot.data()!,
          docSnapshot.id,
          category,
        );

        // Update the state with the fetched item
        state = AsyncValue.data([singleCloth]);
      } else {
        // If no document is found, set an error
        throw Exception("Cloth not found");
      }
    } catch (e, stackTrace) {
      // Handle errors by updating the state
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final clothesProvider =
    StateNotifierProvider<ClothesProvider, AsyncValue<List<Clothes>>>(
  (ref) {
    return ClothesProvider();
  },
);
