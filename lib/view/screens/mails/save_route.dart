import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../mobileapi/api.dart';
import '../../../utill/app_constants.dart';
import '../../base/custom_home_app_bar.dart';
import 'dart:convert';

import '../../base/custom_snackbar.dart';
import 'mail_screen.dart';
class SaveRoute extends StatefulWidget {
  const SaveRoute({Key key}) : super(key: key);

  @override
  State<SaveRoute> createState() => _SaveRouteState();
}

class _SaveRouteState extends State<SaveRoute> {
  final FocusNode _kilometrageFocus = FocusNode();
  final FocusNode _destinationFocus = FocusNode();
  SharedPreferences localStorage;
  bool isCustomerLogin=false;

  TextEditingController _kilometrageController;
  TextEditingController _destinationController;
  TextEditingController _carPlateController;
  TextEditingController _carNameController;

  @override
  void initState() {
    super.initState();
    _kilometrageController = TextEditingController();
    _destinationController = TextEditingController();
    _carPlateController = TextEditingController(text: carPlate);
    _carNameController=TextEditingController(text: carName);
    _getLocalData();
  }
  var carName;
  var carPlate;
  var carType;

  var userId;
  var _userEmail;
  var userData;
  var _userName;
  bool _isLoading=false;
  bool _isLoading1=false;
  _getLocalData() async {
    localStorage = await SharedPreferences.getInstance();
    //make sure customer is logged in
    var userJson=localStorage.getString("user");
    var user=json.decode(userJson);
    // print(user['id']);
    setState(() {
      userId=user['id'];
      _userName=user['name'];
      _userEmail=user['email'];
    });
    getCarInfo();
  }

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
            carType=carInfo['type'] ?? '';
            print(carPlate);
            print(carType);
            print(carName);
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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomRiderAppBar(title: 'CARNE DE ROUTE',isBack:true),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical:20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("CARNE DE ROUTE FORM HISTORY",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: _carPlateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: carPlate,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 10.0,
                          ),
                        ),

                        onSaved: (value) {
                          //  _name = value;
                        },
                        onChanged: (value){

                        },
                        // Rest of your TextFormField properties
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        readOnly: true,
                        controller: _carNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: carName,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 10.0,
                          ),
                        ),

                        onSaved: (value) {
                          //  _name = value;
                        },
                        onChanged: (value){

                        },
                        // Rest of your TextFormField properties
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: _kilometrageController,
                        focusNode: _kilometrageFocus,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Out Kilometrage',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 10.0,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter kilometrage';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          //  _name = value;
                        },
                        onChanged: (value){

                        },
                        // Rest of your TextFormField properties
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        controller: _destinationController,
                        focusNode: _destinationFocus,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Destination..',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 10.0,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter amount';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          //_name = value;
                        },
                        // Rest of your TextFormField properties
                      ),
                    ),
                    const SizedBox(height: 40,),

                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: ElevatedButton(
                        onPressed: () {
                          String km = _kilometrageController.text.trim();
                          String _destination = _destinationController.text.trim();
                          if (km.isEmpty) {
                            showCustomSnackBar('Enter km Please'.tr);
                          }else if (_destination.isEmpty) {
                            showCustomSnackBar('Enter destination'.tr);
                          }
                          else {
                            _save();
                          }

                        },
                        child: const Text('Save route'),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    _isLoading ? Center(child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    )):const Center(child: SizedBox(width: 0,),),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

  void _save() async {
    setState(() {
      _isLoading = true;
    });
    final DateTime now = DateTime.now();
    final String timeOut='${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    print(timeOut);
    final String date='${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    print(date);
    int out=int.parse(_kilometrageController.text);
    var data = {
      'userId':userId,
      'km_out': out,
      'destination':_destinationController.text.toString(),
      'date':date,
      'datetimeIn':'',
      'dateTimeOut':timeOut,
      'plate_number':carPlate,
      'car_type':carType,
      'car_name':carName,
    };

    var res = await CallApi().postData(data, AppConstants.saveRouteUri);
    if (res == null) {
      print('Error: Failed to fetch response');
      setState(() {
        _isLoading = false;
      });
      return;
    }
    else {
      var body = json.decode(res.body);
      print(body);
      if (body['success']==true) {
        print("done");
        Fluttertoast.showToast(
          msg: "Route Saved successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        setState(() {
          _isLoading = false;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return const ConversationScreen();
        }));

      } else {
        setState(() {
          _isLoading = false;
        });
        showCustomSnackBar('Failed to save'.tr);

      }
    }
  }
}
