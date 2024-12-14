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
      final clothesList = snapshot.docs.map((doc) {
        return Clothes.fromFirestore(doc.data());
      }).toList();
      state = AsyncValue.data(clothesList); // Update state with the data
    } catch (e, StackTrace) {
      state = AsyncValue.error(
          e, StackTrace); // If there's an error, update state with the error
    }
  }

  Future<void> getAllProducts() async {
    try {
      state = const AsyncValue.loading();

      final categories = [
        'men',
        'women',
        'kids'
      ];
      List<Clothes> allProducts = [];

      for (String category in categories) {
        final snapshot = await _firestore.collection(category).get();
        allProducts.addAll(snapshot.docs.map((doc) {
          return Clothes.fromFirestore(doc.data());
        }));
      }

      state = AsyncValue.data(allProducts); // Update state with all products
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace); // Handle errors
    }
  }
}

final clothesProvider =
    StateNotifierProvider<ClothesProvider, AsyncValue<List<Clothes>>>(
  (ref) {
    return ClothesProvider();
  },
);
