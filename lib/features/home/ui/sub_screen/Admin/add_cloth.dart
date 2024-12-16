import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/core/helpers/providers/clothes_provider.dart';
import 'package:mobileproject/core/models/clothes.dart';
import 'package:mobileproject/core/widgets/app_text_field.dart';

class AddCloth extends ConsumerStatefulWidget {
  const AddCloth({super.key,});

  @override
  ConsumerState<AddCloth> createState() => _AddClothState();
}

class _AddClothState extends ConsumerState<AddCloth> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final List<String> categories = ['men', 'women', 'kids'];
  String? selectedCategory;
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
  }
  void _onTapAdd() {
    ref.watch(clothesProvider.notifier).addProduct(
          selectedCategory.toString(),
          Clothes(
            uID: '',
            name: _nameController.text,
            description: '',
            price: double.parse(_priceController.text),
            quantity: int.parse(_quantityController.text),
            category: selectedCategory.toString(),
          ),
        );
        _nameController.text = '';
        _priceController.text = '';
        _quantityController.text = '';
        selectedCategory = '';
        Navigator.of(context).pop();
        ref.watch(clothesProvider.notifier).getAllProducts();
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
                  DropdownButton<String>(
                    value: selectedCategory,
                    hint: const Text("Select Category"), // Placeholder text
                    isExpanded: true, // Makes the dropdown full width
                    items: categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedCategory =
                            value; // Update the selected category
                      });
                      // Trigger the callback
                    },
                  ),
                  SizedBox(
                    height: 400.h,
                  ),
                  FilledButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.black),
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 100),
                      ),
                    ),
                    onPressed: _onTapAdd,
                    child: Text(
                      'Add',
                      style: TextStyle(fontSize: 18.sp),
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
