import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/core/helpers/providers/cart_content_provider.dart';
import 'package:mobileproject/core/models/clothes.dart';
import 'package:mobileproject/core/routing/routes.dart';
import 'package:mobileproject/core/theming/colors.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';
import 'package:mobileproject/features/home/ui/widgets/build_empty_cart.dart';
import 'package:mobileproject/features/home/ui/widgets/build_summary_row.dart';
import 'package:mobileproject/features/home/ui/widgets/cart_card.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  // final List<CartItem> cartItems = [
  //   CartItem(name: "Regular Fit Slogan", size: "L", price: 1190, quantity: 2),
  //   CartItem(name: "Regular Fit Polo", size: "M", price: 1100, quantity: 1),
  //   // CartItem(name: "Regular Fit Black", size: "L", price: 1290, quantity: 1),
  // ];
  List<Clothes> cartItems=[] ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartItems = ref.read(cartContentProvider);
  }

  double shippingFee = 80;

  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  double get total => subtotal + shippingFee;

  void incrementQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) cartItems[index].quantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: MyTextStyle.font24BlackBold,
        ),
        backgroundColor: Colors.white,
        // foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context); // Navigate back
        // },
        // },
        // ),
      ),
      body: cartItems.isEmpty
          ? buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return CartItemWidget(
                        item: cartItems[index],
                        onIncrement: () => incrementQuantity(index),
                        onDecrement: () => decrementQuantity(index),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSummaryRow(
                          "Sub-total", "\$${subtotal.toStringAsFixed(2)}"),
                      buildSummaryRow("VAT (%)", "\$0.00"),
                      buildSummaryRow("Shipping fee",
                          "\$${shippingFee.toStringAsFixed(2)}"),
                      const Divider(thickness: 1),
                      buildSummaryRow("Total", "\$${total.toStringAsFixed(2)}",
                          isBold: true),
                      SizedBox(height: 16.h),
                      Center(
                        child: AppTextBtn(
                          buttonText: "Go To Checkout",
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.checkoutScreen,
                                arguments: {
                                  'subTotal': {subtotal},
                                  'shippingFee': shippingFee,
                                  'total': total
                                });
                          },
                          backGroundColor: MyColors.myBlack,
                          textStyle: MyTextStyle.font16WhiteRegular,
                          borderRadius: 10,
                          buttonHeight: 55.h,
                          buttonWidth: 340.w,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
      // body: cartItems.isEmpty
      //     ? buildEmptyCart()
      //     : Column(
      //         children: [
      //           Expanded(
      //             child: ListView.builder(
      //               itemCount: cartItems.length,
      //               itemBuilder: (context, index) {
      //                 return CartItemWidget(
      //                   item: cartItems[index],
      //                   onIncrement: () => incrementQuantity(index),
      //                   onDecrement: () => decrementQuantity(index),
      //                 );
      //               },
      //             ),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.all(16.0),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 buildSummaryRow(
      //                     "Sub-total", "\$${subtotal.toStringAsFixed(2)}"),
      //                 buildSummaryRow("VAT (%)", "\$0.00"),
      //                 buildSummaryRow("Shipping fee",
      //                     "\$${shippingFee.toStringAsFixed(2)}"),
      //                 const Divider(thickness: 1),
      //                 buildSummaryRow("Total", "\$${total.toStringAsFixed(2)}",
      //                     isBold: true),
      //                 SizedBox(height: 16.h),
      //                 Center(
      //                   child: AppTextBtn(
      //                     buttonText: "Go To Checkout",
      //                     onPressed: () {
      //                       Navigator.pushNamed(context, Routes.checkoutScreen,
      //                           arguments: {
      //                             'subTotal': {subtotal},
      //                             'shippingFee': shippingFee,
      //                             'total': total
      //                           });
      //                     },
      //                     backGroundColor: MyColors.myBlack,
      //                     textStyle: MyTextStyle.font16WhiteRegular,
      //                     borderRadius: 10,
      //                     buttonHeight: 55.h,
      //                     buttonWidth: 340.w,
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
    );
  }
}
