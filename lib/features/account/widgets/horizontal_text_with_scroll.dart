import 'package:flutter/material.dart';
import 'package:mobileproject/core/theming/colors.dart';

class HorizontalTextScroller extends StatefulWidget {
  final Function(String) onCategorySelected;

  const HorizontalTextScroller({
    super.key,
    required this.onCategorySelected,
  });

  @override
  _HorizontalTextScrollerState createState() => _HorizontalTextScrollerState();
}

class _HorizontalTextScrollerState extends State<HorizontalTextScroller> {
  final List<String> roomTypes = [
    "General",
    "Account",
    "Service",
    "Payment"
  ];
  int selectedIndex = 0; // To track the selected item

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(roomTypes.length, (index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onCategorySelected(roomTypes[index]); // Notify parent
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Container(
                padding: EdgeInsets.only(top: 8,bottom: 8,left: 15,right: 15),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: isSelected?Colors.black : Colors.white,border: Border.all(color: Colors.black12)),
                child: Text(
                  roomTypes[index],
                  style: TextStyle(
                    fontSize: isSelected ? 18 : 16,
                    fontWeight: isSelected ? FontWeight.normal : FontWeight.normal,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
