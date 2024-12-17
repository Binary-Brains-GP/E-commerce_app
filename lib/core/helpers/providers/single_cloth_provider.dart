import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileproject/core/models/clothes.dart';

class SingleClothProvider extends StateNotifier<Clothes> {
  SingleClothProvider()
      : super(
          Clothes(
              uID: '',
              name: '',
              description: '',
              price: 0.0,
              quantity: 0,
              category: ''),
        );
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void fetchSingleCloth(String uid, String category) async {
    try {
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
        state = singleCloth;
      } else {
        // If no document is found, set an error
        throw Exception("Cloth not found");
      }
    } catch (e) {
      // Handle errors by updating the state
      print('Error: $e');
    }
  }
}

final singleClothProvider = StateNotifierProvider<SingleClothProvider, Clothes>(
  (ref) => SingleClothProvider(),
);
