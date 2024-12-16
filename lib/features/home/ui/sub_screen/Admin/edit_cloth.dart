import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/core/helpers/providers/clothes_provider.dart';
import 'package:mobileproject/core/models/clothes.dart';
import 'package:mobileproject/core/widgets/app_text_field.dart';

class EditCloth extends ConsumerStatefulWidget {
  const EditCloth({super.key, required this.cloth});
  final Clothes cloth;

  @override
  ConsumerState<EditCloth> createState() => _EditClothState();
}

class _EditClothState extends ConsumerState<EditCloth> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _onTapEdit() {
    final updatedCloth = ref.watch(clothesProvider.notifier).editProduct(
          widget.cloth.category,
          widget.cloth.uID,
          name: _nameController.text,
          price: double.tryParse(_priceController.text),
          quantity: int.tryParse(_quantityController.text),
        );
    // setState(() {
    //   ref
    //       .watch(clothesProvider.notifier)
    //       .fetchSingleCloth(widget.cloth.uID, widget.cloth.category);
    // });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: SizedBox(
            height: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                      errorOccurance: false,
                      controller: _nameController,
                      hintText: "Product's name",
                      isSecuredField: false,
                      usePrefixIcon: false,
                      validator: (p0) {
                        return null;
                      },
                      useSuffixIcon: false),
                  SizedBox(
                    height: 20.h,
                  ),
                  //-----------------------------------------------------------------------------------------------
                  AppTextField(
                      errorOccurance: false,
                      controller: _priceController,
                      hintText: "Product's price",
                      isSecuredField: false,
                      usePrefixIcon: false,
                      validator: (p0) {
                        return null;
                      },
                      useSuffixIcon: false),
                  SizedBox(
                    height: 20.h,
                  ),
                  //----------------------------------------------------------------------------------------------
                  AppTextField(
                      errorOccurance: false,
                      controller: _quantityController,
                      hintText: "Product's quantity",
                      isSecuredField: false,
                      usePrefixIcon: false,
                      validator: (p0) {
                        return null;
                      },
                      useSuffixIcon: false),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'Category:  ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      Text(
                        widget.cloth.category,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 400.h,
                  ),
                  Center(
                    child: FilledButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black),
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 100),
                        ),
                      ),
                      onPressed: _onTapEdit,
                      child: Text(
                        'Modify',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
