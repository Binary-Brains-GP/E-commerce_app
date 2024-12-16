import 'package:flutter/material.dart';
import 'package:mobileproject/core/theming/styles.dart';

Widget buildEmptyCart() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey),
        const SizedBox(height: 16),
        Text(
          "Your Cart Is Empty!",
          style: MyTextStyle.font24BlackBold,
        ),
        const SizedBox(height: 8),
        Text(
          "When you add products, they'll appear here.",
          style: MyTextStyle.font16DescriptionTextRegular,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}