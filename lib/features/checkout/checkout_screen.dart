import 'package:flutter/material.dart';
import 'package:mobileproject/core/routing/routes.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';
import 'package:mobileproject/features/account/ui/my_orders_screen.dart';
import 'package:mobileproject/features/home/ui/widgets/build_summary_row.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    super.key,
    required this.shippingFee,
    required this.subTotal,
    required this.total,
    required this.vat,
  });
  final double subTotal;
  final double vat;
  final double shippingFee;
  final double total;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Checkout",
          style: MyTextStyle.font24BlackBold,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              const Text(
                "Payment Method",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextBtn(
                    buttonText: "Card",
                    onPressed: () {},
                    textStyle: MyTextStyle.font14WhiteRegular,
                    buttonWidth: 110.w,
                    buttonHeight: 35.h,
                    verticalPadding: 8.h,
                  ),
                  AppTextBtn(
                    buttonText: "Cash",
                    onPressed: () {},
                    textStyle: MyTextStyle.font14WhiteRegular,
                    buttonWidth: 110.w,
                    buttonHeight: 35.h,
                    verticalPadding: 8.h,
                  ),
                  AppTextBtn(
                    buttonText: "Apple pay",
                    onPressed: () {},
                    textStyle: MyTextStyle.font14WhiteRegular,
                    buttonWidth: 110.w,
                    buttonHeight: 35.h,
                    verticalPadding: 8.h,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  hintText: "VISA **** **** **** 2512",
                  suffixIcon: const Icon(Icons.edit, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(width: 1.5, color: Colors.black),
                  ),
                ),
                onTap: () {},
              ),
              Divider(height: 20.h),

              // Order Summary
              const Text(
                "Order Summary",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              buildSummaryRow(
                  "Sub-total", "\$${widget.subTotal.toStringAsFixed(2)}"),
              buildSummaryRow("VAT (%)", "%${widget.vat}"),
              buildSummaryRow(
                  "Shipping fee", "\$${widget.shippingFee.toStringAsFixed(2)}"),
              const Divider(thickness: 1),
              buildSummaryRow("Total", "\$${widget.total.toStringAsFixed(2)}",
                  isBold: true),

              const SizedBox(height: 20),

              // Promo Code
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter promo code",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(width: 1.5, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  AppTextBtn(
                    buttonWidth: 85.w,
                    buttonHeight: 50.h,
                    textStyle: MyTextStyle.font16WhiteRegular,
                    onPressed: () {},
                    buttonText: "Add",
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Place Order Button
              Center(
                child: AppTextBtn(
                  textStyle: MyTextStyle.font16WhiteRegular,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MyOrdersScreen(),
                    ));
                  },
                  buttonText: "Place Order",
                  buttonWidth: 340.w,
                  buttonHeight: 55.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
