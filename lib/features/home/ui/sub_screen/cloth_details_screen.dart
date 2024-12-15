import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/core/helpers/providers/cart_content_provider.dart';
import 'package:mobileproject/core/models/clothes.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';

class ClothDetailsScreen extends ConsumerWidget {
  const ClothDetailsScreen({super.key, required this.cloth});
  final Clothes cloth;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onTapAddBtn(){
      ref.read(cartContentProvider.notifier).addToCart(cloth);
      print('end of add Button');
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset(cloth.imagePath.toString()),
            Text(
              cloth.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(top: 1),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                width: 1, color: const Color.fromARGB(255, 217, 217, 217))),
        child: SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(color: Colors.grey, fontSize: 20.sp),
                  ),
                  Text(
                    '\$ ${cloth.price.toString()}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 23.sp),
                  ),
                ],
              ),
              AppTextBtn(
                buttonText: "Add to cart",
                textStyle: TextStyle(color: Colors.white),
                onPressed: onTapAddBtn,
                buttonWidth: 240,
                buttonHeight: 54,
              )
            ],
          ),
        ),
      ),
    );
  }
}
