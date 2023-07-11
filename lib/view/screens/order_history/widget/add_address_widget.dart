import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sixvalley_delivery_boy/view/screens/order_history/pob_address.dart';
import '../../../../utill/app_constants.dart';
import '../../../base/custom_snackbar.dart';

class MyFormModal1 extends StatefulWidget {
  final int id;
  final pob;
  const MyFormModal1({Key key, this.id, this.pob}) : super(key: key);

  @override
  _MyFormModal1State createState() => _MyFormModal1State();
}

class _MyFormModal1State extends State<MyFormModal1> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  bool _isChecked = false;
  bool  _isLoading = false;

  TextEditingController _emailController;
  TextEditingController _phoneController;
  TextEditingController _addressController;
  int selectedRadioValue;
  String selectedOption;
  String _currentLocation = '';
  List<String> options = ['Home Address', 'Office Address'];
  List<bool> _isSelected = [false, false];
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    selectedRadioValue = 0;



  }
  setSelectedRadioValue(int value) {
    setState(() {
      selectedRadioValue = value;
      print(selectedRadioValue);
    });
  }
  String generateRandomString() {
    String capitals = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String numbers = '0123456789';

    String randomString = '';

    Random random = Random();

    for (int i = 0; i < 3; i++) {
      int randomIndex = random.nextInt(capitals.length);
      randomString += capitals[randomIndex];
    }

    for (int i = 0; i < 2; i++) {
      int randomIndex = random.nextInt(numbers.length);
      randomString += numbers[randomIndex];
    }

    return randomString;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('VIRTUAL ADDRESS',style: TextStyle(color: Colors.grey),),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [
                ToggleButtons(
                  children: const <Widget>[
                    Text('Private'),
                    Text('Public'),
                  ],
                  isSelected: _isSelected,
                  onPressed: (int index) {
                    setState(() {
                      _isSelected = List.generate(2, (i) => i == index);
                      selectedRadioValue = index;// Store selected value as an integer
                      print(selectedRadioValue);
                    });
                  },
                  selectedColor: Colors.white,
                  fillColor: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0),
                  borderWidth: 1.0,
                  borderColor: Colors.blue,
                  selectedBorderColor: Colors.blue,
                  constraints: const BoxConstraints(
                    minWidth: 50.0,
                    minHeight: 20.0,
                  ),
                ),
                const Text("Visible to public")
              ],),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: _emailController,
                  focusNode: _emailFocus,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 10.0,
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                  onSaved: (value) {
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
                  controller: _phoneController,
                  focusNode: _phoneFocus,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Phone Number',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 10.0,
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Phone required';
                    }
                    return null;
                  },
                  onSaved: (value) {
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
                  controller: _addressController,
                  focusNode: _addressFocus,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Address',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 10.0,
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Address required';
                    }
                    return null;
                  },
                  onSaved: (value) {
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
                child:  DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select Address Type',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedOption,
                  items: options.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      selectedOption = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                decoration: const BoxDecoration(
                    color: CupertinoColors.systemYellow,
                ),
                  child: const Text("Warning Our system will automatically save the current location , so make sure you are in the right place before you click Agree to terms.",style: TextStyle(fontSize: 11,),)),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value) {
                      setState(() {
                        _isChecked = value;
                      });
                    },
                  ),
                  const Expanded(child: Text('Agree to terms and conditions',style: TextStyle(fontSize: 12),)),
                ],
              ),
              SizedBox(height: 10,),
              _isLoading ? const Center(child: CircularProgressIndicator(),):const SizedBox(),


            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            setState(() {
              _isLoading=true;
            });
            String randomString = generateRandomString();
            // print(randomString);
            // print(widget.id);
            if(_isChecked){
              String isVisible="";
              if(selectedRadioValue==1){
                isVisible="Public";
              }
              else{
                isVisible="Private";
              }
              Position position = await Geolocator.getCurrentPosition();
              setState(() {
                _currentLocation =
                '${position.latitude},${position.longitude}';
              });
              if(selectedOption=="Home Address"){
                updateHomeAddress(id:widget.id,email: _emailController.text.toString(),phone: _phoneController.text.toString(),address: _addressController.text.toString(),location: _currentLocation,homeAddressCode: randomString,isHomeVisible: isVisible);

              }
              else{
                updateOfficeAddress(id:widget.id,email: _emailController.text.toString(),phone: _phoneController.text.toString(),address: _addressController.text.toString(),location: _currentLocation,officeAddressCode: randomString,isOfficeVisible:isVisible);

              }

            }else{

              setState(() {
                _isLoading=false;
              });
              showCustomSnackBar('Please accept terms and conditions'.tr);
            }

          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
  Future<void> updateHomeAddress({int id, String email, String phone,String address,String location,String homeAddressCode,String isHomeVisible}) async {
    final url = AppConstants.baseUri+AppConstants.customerHomeLocationUri+'$id';

    final response = await http.put(
      Uri.parse(url),
      body: {
        'homeAddress': address,
        'homeEmail':email,
        'homeLocation':location,
        'homePhone':phone,
        'homeAddressCode':homeAddressCode,
        'homeVisible':isHomeVisible,
      },
    );
    if (response.statusCode == 200) {
      // Customer updated successfully
      Fluttertoast.showToast(
        msg: " Updated successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return  PobAddress(pob: widget.pob,);
      }));
      setState(() {
        _isLoading = false;
      });
    } else {
      // Error occurred during the update
      print('Error updating home address: ${response.body}');
      setState(() {
        _isLoading = false;
      });
      showCustomSnackBar('Failed to update home address'.tr);
    }
  }


  Future<void> updateOfficeAddress({int id, String email, String phone,String address,String location,officeAddressCode,String isOfficeVisible}) async {
    final url = AppConstants.baseUri+AppConstants.customerOfficeLocationUri+'$id';
    final response = await http.put(
      Uri.parse(url),
      body: {
        'officeAddress': address,
        'officeEmail':email,
        'officeLocation':location,
        'officePhone':phone,
        'officeAddressCode':officeAddressCode,
        'officeVisible':isOfficeVisible,
      },
    );
    if (response.statusCode == 200) {
      // Customer updated successfully
      Fluttertoast.showToast(
        msg: "updated successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      setState(() {
        _isLoading = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return  PobAddress(pob: widget.pob,);
      }));
    } else {
      // Error occurred during the update
      print('Error updating office address: ${response.body}');
      setState(() {
        _isLoading = false;
      });
      showCustomSnackBar('Failed to update office address'.tr);
    }
  }
}


