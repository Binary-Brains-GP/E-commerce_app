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
}

final cartContentProvider =
    StateNotifierProvider<CartContentProvider, List<Clothes>>(
  (ref) => CartContentProvider(),
);
