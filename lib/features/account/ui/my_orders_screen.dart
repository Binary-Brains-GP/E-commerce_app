import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileproject/core/helpers/providers/cart_content_provider.dart';
import 'package:mobileproject/core/models/clothes.dart';
import 'package:mobileproject/core/theming/colors.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';
import 'package:mobileproject/features/account/widgets/leave_review_sheet.dart';
import 'package:mobileproject/features/account/widgets/order_card.dart';

class MyOrdersScreen extends ConsumerStatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  ConsumerState<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends ConsumerState<MyOrdersScreen> {
  // To track the selected button
  bool isOngoingSelected = true;
  List<Clothes> cartItems = [];
  void _showLeaveReviewSheet(BuildContext context, Clothes cloth) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => LeaveReviewSheet(
        cloth: cloth,
      ), // Review sheet widget
    );
  }

  @override
  Widget build(BuildContext context) {
    cartItems = ref.watch(cartContentProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "My Orders",
          style: MyTextStyle.font22BlackSemiBold,
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.myVeryLightGray,
              ),
              height: 60,
              width: 341,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ongoing Button
                  AppTextBtn(
                    backGroundColor: isOngoingSelected
                        ? Colors.white
                        : MyColors.myVeryLightGray,
                    verticalPadding: 1,
                    buttonHeight: 35,
                    buttonWidth: 160,
                    buttonText: "Ongoing",
                    textStyle: TextStyle(
                      fontSize: 14,
                      color:
                          isOngoingSelected ? Colors.black87 : Colors.black45,
                    ),
                    onPressed: () {
                      setState(() {
                        isOngoingSelected = true;
                      });
                    },
                  ),
                  // Complete Button
                  AppTextBtn(
                    backGroundColor: isOngoingSelected
                        ? MyColors.myVeryLightGray
                        : Colors.white,
                    verticalPadding: 1,
                    buttonHeight: 35,
                    buttonWidth: 160,
                    buttonText: "Complete",
                    textStyle: TextStyle(
                      fontSize: 14,
                      color:
                          isOngoingSelected ? Colors.black45 : Colors.black87,
                    ),
                    onPressed: () {
                      setState(() {
                        isOngoingSelected = false;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (isOngoingSelected == false)
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: OrderCard(
                      isOngoingSelected: isOngoingSelected,
                      cloth: cartItems[index],
                      onTrackOrder: () {
                        _showLeaveReviewSheet(
                          context,
                          cartItems[index],
                        ); // Open review sheet here
                      },
                    ),
                  ),
                ),
              ),
            if (isOngoingSelected)
              OrderCard(
                  isOngoingSelected: isOngoingSelected,
                  cloth: Clothes(
                      uID: ' 1IQufHFpQbAevti69LcA ',
                      name: 'Denim Jacket',
                      description: "Classic denim jacket perfect for layering.",
                      price: 70,
                      quantity: 5,
                      category: 'women',
                      imagePath: 'assets/images/Denim Jacket.jpg'),
                  onTrackOrder: () {}),
            // AppTextBtn(
            //   buttonText: 'Back to home',
            //   textStyle: const TextStyle(color: Colors.white, fontSize: 19),
            //   onPressed: onTapBack,
            // )
          ],
        ),
      ),
    );
  }
}
