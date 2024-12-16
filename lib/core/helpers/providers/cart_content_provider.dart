import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileproject/core/models/clothes.dart';

class CartContentProvider extends StateNotifier<List<Clothes>> {
  CartContentProvider() : super([]);

  void addToCart(Clothes cloth) {
    final isExist = state.contains(cloth);
    print(isExist);
    if (isExist) {
      cloth.cartQuantity += 1;
    } else {
      cloth.cartQuantity += 1;
      state = [...state, cloth];
    }
    print(cloth.cartQuantity);
  }

  //----------------IMPORTANT NOTE FOR RAMY-----------------------------------------------
  /*This function will return true as long as the item is in the cart,
  but when the item's cartQuantity in cart is 1 and the remove button is clicked it returns false
  and there you should delete it from the UI too --------------------------*/
  bool decreamentQuantity(Clothes cloth) {
    var isExist = state.contains(cloth);
    if (isExist && cloth.cartQuantity == 1) {
      state = state.where((m) => m.uID != cloth.uID).toList();
      cloth.cartQuantity = 0;
      return false;
    } else if (isExist) {
      cloth.cartQuantity -= 1;
      return true;
    }
    return false;
  }

  void removeFromCart(Clothes cloth) {
    state = state.where((m) => m.uID != cloth.uID).toList();
    cloth.cartQuantity = 0;
  }

  void addListToUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try{
    final String? userID = _auth.currentUser?.uid;

    if(userID == null){
      throw Exception("No user signed in");
    }

    final List<Map<String,dynamic>> cartItems = state.map((e) => e.toMap(),).toList();

    final userDoc = _firestore.collection('users').doc(userID);
    await userDoc.update({
      'cartItems': cartItems,
    });
    }catch(e){
      print("Error: $e");
    }
  }
}

final cartContentProvider =
    StateNotifierProvider<CartContentProvider, List<Clothes>>(
  (ref) => CartContentProvider(),
);
