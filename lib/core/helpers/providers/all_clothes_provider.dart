import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileproject/core/models/clothes.dart';

class AllClothesProvider extends StateNotifier<AsyncValue<List<Clothes>>> {
  AllClothesProvider() : super(const AsyncValue.loading());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> getAllProducts() async {
    try {
      state = const AsyncValue.loading();

      final categories = ['men', 'women', 'kids'];
      List<Clothes> allProducts = [];

      for (String category in categories) {
        final snapshot = await _firestore.collection(category).get();
        final categoryProducts = await Future.wait(snapshot.docs.map((doc) async {
          return await Clothes.fromFirestoreAsync(doc.data(), doc.id, category);
        }));

        allProducts.addAll(categoryProducts);
      }

      state = AsyncValue.data(allProducts); // Update state with all products
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace); // Handle errors
    }
  }

  Future<void> deleteCloth(String category, String clothId) async {
    try {
      // Remove the cloth from Firestore
      await _firestore.collection(category).doc(clothId).delete();

      // Update the state by filtering out the deleted cloth
      final currentClothes = state.value ?? [];
      state = AsyncValue.data(
        currentClothes.where((cloth) => cloth.name != clothId).toList(),
      );
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace); // Handle errors
    }
  }
}

final allClothesProvider =
    StateNotifierProvider<AllClothesProvider, AsyncValue<List<Clothes>>>(
  (ref) {
    return AllClothesProvider();
  },
);
