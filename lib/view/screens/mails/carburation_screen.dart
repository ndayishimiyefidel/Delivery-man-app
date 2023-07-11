import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/view/screens/mails/save_calibration.dart';
import '../../../mobileapi/api.dart';
import '../../../utill/app_constants.dart';
import '../../base/custom_home_app_bar.dart';
import '../../base/custom_snackbar.dart';
import 'package:http/http.dart' as http;

import '../../base/no_data_screen.dart';
class CarburationScreen extends StatefulWidget {
  const CarburationScreen({Key key}) : super(key: key);

  @override
  State<CarburationScreen> createState() => _CarburationScreenState();
}

class _CarburationScreenState extends State<CarburationScreen> {
  SharedPreferences localStorage;
  bool isCustomerLogin=false;
  List<dynamic> _driverCalibration = [];


  @override
  void initState() {
    super.initState();
    _getLocalData();
  }


  var userId;
  var _userEmail;
  var userData;
  var _userName;
  bool _isLoading=false;
  _getLocalData() async {
    localStorage = await SharedPreferences.getInstance();
    //make sure customer is logged in
    var userJson=localStorage.getString("user");
    var user=json.decode(userJson);
    setState(() {
      userId=user['id'];
      _userName=user['name'];
      _userEmail=user['email'];
    });
    loadDriverRoute();
  }

  loadDriverRoute() async {
    setState(() {
      _isLoading = true;
    });

    var res = await http.get(Uri.parse(
        AppConstants.baseUri + AppConstants.getMilleageUri+'$userId'));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      print(jsonData);
      if (jsonData['data'].isNotEmpty) {
        setState(() {
          _driverCalibration = jsonData['data'];
          _isLoading= false;
        });
      }
      if (jsonData['data'].isEmpty) {
        setState(() {
          _isLoading = false;
          print(jsonData);
        });
      }
    }
  }
  @override
  void dispose() {
    super.dispose();
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white, size: 30),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const SaveCalibration();
          }));
        },
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 10,
      ),
      appBar: const CustomRiderAppBar(title: 'CARS CALIBRATION HISTORY',isBack: true,),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            Stack(
              children: [
                !_isLoading ? _buildContent(): _buildLoadingIndicator(),
              ],
            ),

          ],
        ),
      ),
    );
  }
  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  Widget _buildContent() {
    return _driverCalibration.isNotEmpty
        ? SizedBox(
      height: 400,
      child: ListView.builder(
        itemCount: _driverCalibration.length,
        itemBuilder: ((context, index) {
          return Card(
            elevation: 10,
            margin: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date: " + _driverCalibration[index]['date'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Car Plate: ${_driverCalibration[index]['plate_number']}",
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Car Name: ${_driverCalibration[index]['car_name']}",
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Car Type: ${_driverCalibration[index]['car_type']}",
                      ),
                      const SizedBox(height: 5),

                      Text(
                        "Litres: ${_driverCalibration[index]['liters']}",
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Milleage: ${_driverCalibration[index]['milleage']}",
                      ),

                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    )
        : const Center(child: NoDataScreen());
  }


}

