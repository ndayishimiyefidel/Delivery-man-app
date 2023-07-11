import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/base/title_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/home/widget/earn_statement1.dart';
import 'package:sixvalley_delivery_boy/view/screens/home/widget/earn_statement_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/home/widget/home_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/home/widget/trip_status_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/home/widget/view_on_map.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/permission_dialog.dart';

import '../../../utill/app_constants.dart';
import 'cusomer_international.dart';
import 'customer_national_mail.dart';

class HomeScreen1 extends StatefulWidget {
  final Function(int index) onTap;
  const HomeScreen1({Key key, @required this.onTap}) : super(key: key);

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {

  Future<void> _loadData(BuildContext context) async {
    await Get.find<ProfileController>().getProfile();

  }

  bool isLoading=false;
  final GlobalKey<ScaffoldState> _scaffoldkey =  GlobalKey<ScaffoldState>();

  int rowCount=0;
  int numberDelivery=0;
  int numberPending=0;
  var userId;
  var _userEmail;
  var userData;
  var _userName;

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson=localStorage.getString("user");
    var user=json.decode(userJson);
    // print("userId");
    // print(user['name']);
    setState(() {
      userId=user['id'];
      _userName=user['name'];
      _userEmail=user['email'];
    });
  }



  @override
  void initState() {
    _checkPermission(context);
    _getUserInfo();
    // _loadData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      key: _scaffoldkey,
      appBar: CustomRiderAppBar(title: ''.tr, isSwitch: true),
      body: SingleChildScrollView(
        child: Column(

          children: const [

          ],
        ),
      ),
    );
  }

  void _checkPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if(permission == LocationPermission.denied) {
      showDialog(context: context, barrierDismissible: false, builder: (context) => PermissionDialog(isDenied: true,
          onPressed: () async {
            Navigator.pop(context);
            await Geolocator.requestPermission();

          }));
    }else if(permission == LocationPermission.deniedForever) {
      showDialog(context: context, barrierDismissible: false, builder: (context) => PermissionDialog(isDenied: false,
          onPressed: () async {
            Navigator.pop(context);
            await Geolocator.openAppSettings();

          }));
    }
  }
}




