import 'package:flutter/material.dart';
import 'package:mobileproject/core/theming/colors.dart';
import 'package:mobileproject/core/theming/styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationScreen> {
  // Switch states for each setting
  bool generalNotifications = true;
  bool sound = true;
  bool vibrate = false;
  bool specialOffers = true;
  bool promoDiscounts = false;
  bool payments = false;
  bool cashback = true;
  bool appUpdates = false;
  bool newServiceAvailable = true;
  bool newTipsAvailable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Notifications',
          style: MyTextStyle.font22BlackSemiBold,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Divider(thickness: 3,color: MyColors.myVeryLightGray,),

          _buildNotificationTile(
            title: 'General Notifications',
            value: generalNotifications,
            onChanged: (val) {
              setState(() {
                generalNotifications = val;
              });
            },
          ),
          Divider(),

          _buildNotificationTile(
            title: 'Sound',
            value: sound,
            onChanged: (val) {
              setState(() {
                sound = val;
              });
            },
          ),
          Divider(),

          _buildNotificationTile(
            title: 'Vibrate',
            value: vibrate,
            onChanged: (val) {
              setState(() {
                vibrate = val;
              });
            },
          ),
          Divider(),
          _buildNotificationTile(
            title: 'Special Offers',
            value: specialOffers,
            onChanged: (val) {
              setState(() {
                specialOffers = val;
              });
            },
          ),
          Divider(),

          _buildNotificationTile(
            title: 'Promo & Discounts',
            value: promoDiscounts,
            onChanged: (val) {
              setState(() {
                promoDiscounts = val;
              });
            },
          ),          Divider(),


          _buildNotificationTile(
            title: 'Payments',
            value: payments,
            onChanged: (val) {
              setState(() {
                payments = val;
              });
            },
          ),
          Divider(),

          _buildNotificationTile(
            title: 'Cashback',
            value: cashback,
            onChanged: (val) {
              setState(() {
                cashback = val;
              });
            },
          ),
          Divider(),

          _buildNotificationTile(
            title: 'App Updates',
            value: appUpdates,
            onChanged: (val) {
              setState(() {
                appUpdates = val;
              });
            },
          ),

        ],
      ),
    );
  }

  Widget _buildNotificationTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: MyTextStyle.font18LightBlackRegular),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.black,
        inactiveThumbColor: Colors.white,
        thumbColor: const WidgetStatePropertyAll(Colors.white ),
        trackOutlineColor:WidgetStatePropertyAll(Colors.black87.withOpacity(0)),
        trackOutlineWidth: WidgetStatePropertyAll(0),
        activeTrackColor: Colors.black,
      ),
    );
  }
}
