import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileproject/core/models/clothes.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';

class LeaveReviewSheet extends ConsumerStatefulWidget {
  const LeaveReviewSheet({super.key, required this.cloth});
  final Clothes cloth;
  @override
  ConsumerState<LeaveReviewSheet> createState() => _LeaveReviewSheetState();
}

class _LeaveReviewSheetState extends ConsumerState<LeaveReviewSheet> {
  int _selectedStars = 0; // To track selected star rating
  final TextEditingController _reviewController = TextEditingController();
  // Widget to build star icons
  Widget _buildStar(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStars = index;
        });
      },
      child: Icon(
        Icons.star,
        size: 36,
        color: index <= _selectedStars ? Colors.amber : Colors.grey[300],
      ),
    );
  }

  void onSubmit() {
    widget.cloth.rate = _selectedStars;
    widget.cloth.feedback = _reviewController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 25,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text(
                'Leave a Review',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel))
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          const Text(
            'How was your order?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          Text(
            'Please give your rating and also your review.',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),
          // Star Rating Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) => _buildStar(index + 1)),
          ),
          const SizedBox(height: 20),
          // Review TextField
          TextField(
            controller: _reviewController,
            decoration: InputDecoration(
              hintText: 'Write your review...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                // Default border color
                borderSide: const BorderSide(color: Colors.black12, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                // Border color when TextField is focused
                borderSide: const BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          // Submit Button
          AppTextBtn(
            buttonText: "Submit",
            textStyle: MyTextStyle.font18WhiteRegular,
            onPressed: onSubmit,
            buttonWidth: double.maxFinite,
          )
        ],
      ),
    );
  }
}
