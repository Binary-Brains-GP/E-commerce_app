import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/core/helpers/providers/cart_content_provider.dart';
import 'package:mobileproject/core/models/clothes.dart';
import 'package:mobileproject/core/theming/colors.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';
import 'package:mobileproject/features/checkout/checkout_screen.dart';
import 'package:mobileproject/features/home/ui/widgets/build_empty_cart.dart';
import 'package:mobileproject/features/home/ui/widgets/build_summary_row.dart';
import 'package:mobileproject/features/home/ui/widgets/cart_card.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  List<Clothes> cartItems = [];
  bool isExist = false;
  final double shippingFee = 80;
  final double vat = 10;

  double get subTotal =>
      cartItems.fold(0, (sum, item) => sum + (item.price + item.price * vat/100) * item.cartQuantity);

  double get total => subTotal + shippingFee;

  void incrementQuantity(Clothes cloth) {
    setState(() {
      ref.watch(cartContentProvider.notifier).addToCart(cloth);
    });
  }

  void decrementQuantity(Clothes cloth) {
    setState(() {
      isExist =
          ref.watch(cartContentProvider.notifier).decreamentQuantity(cloth);
    });
  }

  void removeProduct(Clothes cloth) {
    setState(() {
      ref.watch(cartContentProvider.notifier).removeFromCart(cloth);
    });
  }

  @override
  Widget build(BuildContext context) {
    cartItems = ref.watch(cartContentProvider);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "My Cart",
          style: MyTextStyle.font24BlackBold,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
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
                        onIncrement: () => incrementQuantity(cartItems[index]),
                        onDecrement: () => decrementQuantity(cartItems[index]),
                        onRemove: () => removeProduct(cartItems[index]),
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
                          "Sub-total", "\$${subTotal.toStringAsFixed(2)}"),
                      buildSummaryRow("VAT (%)", "%$vat"),
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
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CheckoutScreen(
                                orderedItems: cartItems,
                                shippingFee: shippingFee,
                                subTotal: subTotal,
                                total: total,
                                vat: vat,
                              ),
                            ));
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
    );
  }
}
