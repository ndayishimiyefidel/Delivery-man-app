import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/base/no_data_screen.dart';


class NotificationScreen1 extends StatefulWidget {
  const NotificationScreen1({Key key}) : super(key: key);

  @override
  State<NotificationScreen1> createState() => _NotificationScreen1State();
}

class _NotificationScreen1State extends State<NotificationScreen1> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: CustomRiderAppBar(title: 'P.O Box Payments'.tr),
      body:  const Center(child: NoDataScreen()),
    );
  }
}


