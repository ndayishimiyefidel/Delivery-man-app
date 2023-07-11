import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/base/title_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/applications/poxbox_appplication.dart';
import 'package:sixvalley_delivery_boy/view/screens/home/widget/earn_statement_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/home/widget/ongoing_order_card_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/home/widget/trip_status_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/permission_dialog.dart';
import 'package:http/http.dart' as http;

import '../../../utill/app_constants.dart';
import '../../base/no_data_screen.dart';
class PobManagement extends StatefulWidget {
  final Function(int index) onTap;
  const PobManagement({Key key, this.onTap}) : super(key: key);

  @override
  State<PobManagement > createState() => _PobManagementState();
}

class _PobManagementState extends State<PobManagement> {

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
  List<dynamic> _carInfo = [];

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
  }

  int numberNat = 0;
  int numberInt = 0;
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
        print(numberInt);
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue, onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return const PhysicalPoxBoxApplication();
        }));
      },
        elevation: 2,
        child: const Icon(Icons.add,color: Colors.white,size: 30,),
      ),
      key: _scaffoldkey,
      appBar: CustomRiderAppBar(title: 'P.O. Box  Management'.tr, isSwitch: false,isBack:true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Dimensions.paddingSizeDefault),
            TripStatusModifiedWidget(onTap: (int index) => widget.onTap(index),),
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




