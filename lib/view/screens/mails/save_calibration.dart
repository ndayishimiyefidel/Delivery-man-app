import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';

import '../../../mobileapi/api.dart';
import '../../base/custom_home_app_bar.dart';
import '../../base/custom_snackbar.dart';
import 'carburation_screen.dart';
class SaveCalibration extends StatefulWidget {
  const SaveCalibration({Key key}) : super(key: key);

  @override
  State<SaveCalibration> createState() => _SaveCalibrationState();
}

class _SaveCalibrationState extends State<SaveCalibration> {
  SharedPreferences localStorage;
  bool isCustomerLogin=false;
  final FocusNode _literFocus = FocusNode();
  final FocusNode _milleageFocus = FocusNode();


  TextEditingController _literController;
  TextEditingController _milleageController;
  TextEditingController _carPlateController;
  TextEditingController _carNameController;

  @override
  void initState() {
    super.initState();
    _literController = TextEditingController();
    _milleageController = TextEditingController();
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

  @override
  void dispose() {
    _literController.dispose();
    _milleageController.dispose();
    _carNameController.dispose();
    _carPlateController.dispose();
    super.dispose();
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomRiderAppBar(title: 'ADD CAR CALIBRATION',isBack: true,),

      body: SingleChildScrollView(child: Column(
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
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      readOnly: true,
                      controller: _carNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: carType,
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
                      controller: _literController,
                      focusNode: _literFocus,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Litres..',
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
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      controller: _milleageController,
                      focusNode: _milleageFocus,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Milleage..',
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 10.0,
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter calibration';
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
                        String km = _literController.text.trim();
                        String _destination = _milleageController.text.trim();
                        if (km.isEmpty) {
                          showCustomSnackBar('Enter km Please'.tr);
                        }else if (_destination.isEmpty) {
                          showCustomSnackBar('Enter destination'.tr);
                        }
                        else {
                          _save();
                        }

                      },
                      child: const Text('Save'),
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
      ),),
    );
  }
  void _save() async {
    setState(() {
      _isLoading = true;
    });
    print("saved");
    final DateTime now = DateTime.now();
    final String timeOut='${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    print(timeOut);
    final String date='${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    var data = {
      'userId':userId,
      'liters': _literController.text.toString(),
      'milleage':_milleageController.text.toString(),
      'date':'$date $timeOut',
      'plate_number':carPlate,
      'car_type':carType,
      'car_name':carName,
    };

    var res = await CallApi().postData(data, AppConstants.saveMilleageUri);
    if (res == null) {
      print('Error: Failed to fetch response');
      setState(() {
        _isLoading = false;
      });
      return;
    }
    else {
      var body = json.decode(res.body);
      if (body['success']==true) {
        Fluttertoast.showToast(
          msg: "Calibration successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        setState(() {
          _isLoading = false;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return const CarburationScreen();
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
