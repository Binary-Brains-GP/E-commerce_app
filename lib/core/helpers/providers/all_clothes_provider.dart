import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileproject/core/models/clothes.dart';

class AllClothesProvider extends StateNotifier<AsyncValue<List<Clothes>>> {
  AllClothesProvider() : super(const AsyncValue.loading());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

final allClothesProvider =
    StateNotifierProvider<AllClothesProvider, AsyncValue<List<Clothes>>>(
  (ref) {
    return AllClothesProvider();
  },
);
