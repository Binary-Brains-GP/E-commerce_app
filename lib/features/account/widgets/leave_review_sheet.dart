import 'package:flutter/material.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';

class LeaveReviewSheet extends StatefulWidget {
  @override
  _LeaveReviewSheetState createState() => _LeaveReviewSheetState();
}

class _LeaveReviewSheetState extends State<LeaveReviewSheet> {
  int _selectedStars = 0; // To track selected star rating
  TextEditingController _reviewController = TextEditingController();

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
              Text(
                'Leave a Review',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.cancel))
            ],
          ),
          Divider(),
          SizedBox(height: 10),
          Text(
            'How was your order?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          Text(
            'Please give your rating and also your review.',
            style: TextStyle(color: Colors.grey[600]),
          ),
          SizedBox(height: 20),
          // Star Rating Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) => _buildStar(index + 1)),
          ),
          SizedBox(height: 20),
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
                borderSide: BorderSide(color: Colors.black12, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                // Border color when TextField is focused
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            maxLines: 3,
          ),
          SizedBox(height: 20),
          // Submit Button
          AppTextBtn(
            buttonText: "Submit",
            textStyle: MyTextStyle.font18WhiteRegular,
            onPressed: () {},
            buttonWidth: double.maxFinite,
          )
        ],
      ),
    );
  }
}
