import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/core/helpers/providers/all_clothes_provider.dart';
import 'package:mobileproject/core/helpers/providers/cart_content_provider.dart';
import 'package:mobileproject/core/helpers/providers/clothes_provider.dart';
import 'package:mobileproject/core/helpers/providers/privileges_provider.dart';
import 'package:mobileproject/core/models/clothes.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';
import 'package:mobileproject/features/home/ui/sub_screen/Admin/edit_cloth.dart';
import 'package:mobileproject/features/home/ui/widgets/size_button.dart';
import 'package:transparent_image/transparent_image.dart';

class ClothDetailsScreen extends ConsumerStatefulWidget {
  const ClothDetailsScreen(
      {super.key, required this.cloth, required this.category});
  final Clothes cloth;
  final String category;

  @override
  ConsumerState<ClothDetailsScreen> createState() => _ClothDetailsScreenState();
}

class _ClothDetailsScreenState extends ConsumerState<ClothDetailsScreen> {
  String? selectedSize; // Track the selected size

  void _onSizeSelected(String size) {
    setState(() {
      selectedSize = size; // Update the selected size
    });
  }

  void onTapAddBtn() {
    widget.cloth.size = selectedSize.toString();
    ref.read(cartContentProvider.notifier).addToCart(widget.cloth);
    print("product added to car-----------1");
  }

  void _onTapDeleteProduct() {
    print('--------------${widget.cloth.category}');
    ref
        .watch(allClothesProvider.notifier)
        .deleteCloth(widget.cloth.category, widget.cloth.uID);
    Navigator.of(context).pop();
    if (widget.category == "all") {
      ref.watch(clothesProvider.notifier).getAllProducts();
    } else {
      ref.watch(clothesProvider.notifier).getClothes(widget.category);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(privilegesProvider).valueOrNull!;
    final isAdmin = currentUser.isAdmin;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 120,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage(widget.cloth.imagePath.toString()),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              widget.cloth.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              widget.cloth.description,
              style: const TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Choose Size",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizeButton(
                  letter: "S",
                  isSelected: selectedSize == "S",
                  onSelect: () => _onSizeSelected("S"),
                ),
                SizedBox(
                  width: 10.w,
                ),
                SizeButton(
                  letter: "M",
                  isSelected: selectedSize == "M",
                  onSelect: () => _onSizeSelected("M"),
                ),
                SizedBox(
                  width: 10.w,
                ),
                SizeButton(
                  letter: "L",
                  isSelected: selectedSize == "L",
                  onSelect: () => _onSizeSelected("L"),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            //------------------------------Admin functionalities-----------
            if (isAdmin)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilledButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.black)),
                      onPressed: () {
                        showModalBottomSheet(
                          useSafeArea: true,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => EditCloth(
                            cloth: widget.cloth,
                          ),
                        );
                      },
                      child: Text("Edit product")),
                  FilledButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.black)),
                      onPressed: _onTapDeleteProduct,
                      child: Text("Delete product")),
                ],
              ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.only(top: 1),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: const Color.fromARGB(255, 217, 217, 217),
          ),
        ),
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
                    '\$ ${widget.cloth.price.toString()}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 23.sp),
                  ),
                ],
              ),
              AppTextBtn(
                buttonText: "Add to cart",
                textStyle: TextStyle(color: Colors.white, fontSize: 20.sp),
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
