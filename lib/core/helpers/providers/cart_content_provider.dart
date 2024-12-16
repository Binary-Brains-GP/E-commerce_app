import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileproject/core/models/clothes.dart';

class CartContentProvider extends StateNotifier<List<Clothes>> {
  CartContentProvider() : super([]);

  void addToCart(Clothes cloth) {
    print("entered add to cart");
    final isExist = state.contains(cloth);
    // print(state[0].name);
    print('is Exist statement: $isExist');
    if (isExist) {
      print('If-------------------------------');
      cloth.cartQuantity += 1;
    } else {
      print('else--------------------------------');
      cloth.cartQuantity += 1;
      print('add quantity-----------------');
      state = [...state, cloth];
      print('add to state');
    }

    print(state[0].cartQuantity);
  }
  //----------------IMPORTANT NOTE FOR RAMY-----------------------------------------------
  /*This function will return true as long as the item is in the cart,
  but when the item's cartQuantity in cart is 1 and the remove button is clicked it returns false
  and there you should delete it from the UI too --------------------------*/
  bool removeFromCart(Clothes cloth) {
    var isExist = state.contains(cloth);
    if (isExist && cloth.cartQuantity == 1) {
      state = state.where((m) => m.name != cloth.name).toList();
      cloth.cartQuantity = 0;
      return false;
    } else if (isExist) {
      cloth.cartQuantity -= 1;
      return true;
    }
    return false;
  }
}

final cartContentProvider =
    StateNotifierProvider<CartContentProvider, List<Clothes>>(
  (ref) => CartContentProvider(),
);
