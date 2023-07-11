import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/screens/home/widget/earn_statement_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/home/widget/trip_status_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/permission_dialog.dart';
import 'package:http/http.dart' as http;

import '../../../utill/app_constants.dart';
class HomeScreen extends StatefulWidget {
  final Function(int index) onTap;
  const HomeScreen({Key key, @required this.onTap}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
    // print(user['id']);
    setState(() {
      userId=user['id'];
      _userName=user['name'];
      _userEmail=user['email'];
    });

    totalMails();
    // getPending();
    // getDelivery();
    getCarInfo();
    nationalMails();
    internationalMails();
    countHomeDeliveryMails();
  }

  int numberNat = 0;
  int numberInt = 0;
  int numberHome=0;
  Future<void> totalMails() async {
    final response = await http.get(Uri.parse(AppConstants.baseUri+AppConstants.getTotalMailUri+'$userId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        rowCount = data['count'];
        print(rowCount);
      });
    } else {
      // Handle error
    }
  }

  var carName;
  var carPlate;
  Future<void> getCarInfo() async {
    final response = await http.get(Uri.parse(AppConstants.baseUri + AppConstants.getCarInfoUri + '$userId'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData is List) {
        if (jsonData.isNotEmpty) {
          final carInfo = jsonData[0] as Map<String, dynamic>;

          setState(() {
            carName = carInfo['name'] ?? '';
            carPlate = carInfo['plate_number'] ?? '';
            print(carPlate);
          });
        } else {
          print('Empty car list');
          // Handle empty list case
        }
      } else {
        print('Invalid response format');
        // Handle invalid response format
      }
    } else {
      print('Error: ${response.statusCode}');
      // Handle error
    }
  }
  Future<void> nationalMails() async {
    final response =
    await http.get(Uri.parse(AppConstants.baseUri + AppConstants.getNationalMailUri + '$userId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        numberNat = data['count'];
        print("nationa email");
        print(numberNat);
      });
    } else {
      // Handle error
    }
  }

  Future<void> internationalMails() async {
    final response =
    await http.get(Uri.parse(AppConstants.baseUri + AppConstants.getInternationalMailUri + '$userId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        numberInt = data['count'];
        print("International");
        print(numberInt);
      });
    } else {
      // Handle error
    }
  }
  Future<void> countHomeDeliveryMails() async {
    final response =
    await http.get(Uri.parse(AppConstants.baseUri + AppConstants.countHomeDeliveryMailUri+ '$userId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        numberHome = data['count'];
        print("home delivery");
        print(numberHome);
      });
    } else {
      // Handle error
    }
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
      key: _scaffoldkey,
      appBar: CustomRiderAppBar(title: 'dashboard'.tr, isSwitch: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
             EarnStatementWidget(profile:  '$_userName',mails: '$rowCount',email: '$_userEmail',carName: carName!=null ?'$carName':'No car Assigned',carPlate: carPlate!=null?'$carPlate':'No plate Number',),
            SizedBox(height: Dimensions.paddingSizeDefault),
            TripStatusWidget(onTap: (int index) => widget.onTap(index),countNational: numberNat,countInternational:numberInt,countHomeDelivery: numberHome
              ,),
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




