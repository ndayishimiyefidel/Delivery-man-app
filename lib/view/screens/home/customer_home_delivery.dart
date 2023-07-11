import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utill/app_constants.dart';
import '../../base/custom_home_app_bar.dart';
import '../../base/no_data_screen.dart';

class DriverHomeDelivery extends StatefulWidget {
  const DriverHomeDelivery({Key key}) : super(key: key);

  @override
  State<DriverHomeDelivery> createState() => _DriverHomeDeliveryState();
}

class _DriverHomeDeliveryState extends State<DriverHomeDelivery> {
  bool _loading = false;
  List<dynamic> _driverHomeDelivery = [];
  SharedPreferences localStorage;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRiderAppBar(title: 'MY HOME DELIVERY REQUEST.'.tr, isSwitch: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        child: Stack(
          children: [
            Visibility(
              visible: _loading,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            _driverHomeDelivery.isNotEmpty
                ? ListView.builder(
              itemCount: _driverHomeDelivery.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8,bottom: 16,left: 10,right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Security code: ${_driverHomeDelivery[index]['securityCode']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text("Dispatch Number: " +
                            _driverHomeDelivery[index]['dispatchNumber'],
                          style: const TextStyle(),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Mail Number: ${_driverHomeDelivery[index]['mailsNumber']}",
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Sent Date: ${_driverHomeDelivery[index]['sentDate']}",
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Delivery Date: ${_driverHomeDelivery[index]['deliveryDate']}",
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
                : Visibility(
              visible: !_loading,
              child: const NoDataScreen(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadHomeDeliveryList();
  }

  loadHomeDeliveryList() async {
    setState(() {
      _loading = true;
    });

    localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString("user");
    var user = json.decode(userJson);
    var loggedInUserId = user['id'];
    print("user id");
    print(loggedInUserId);
    var res = await http.get(Uri.parse(
        AppConstants.baseUri + AppConstants.driverHomeRequestUri+'$loggedInUserId'));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      print(jsonData);
      if (jsonData['data'].isNotEmpty) {
        setState(() {
          _driverHomeDelivery = jsonData['data'];
        });
      }
      setState(() {

        _loading = false;
      });
    }
  }
}
