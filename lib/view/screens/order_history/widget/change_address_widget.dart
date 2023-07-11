import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sixvalley_delivery_boy/view/screens/order_history/pob_address.dart';
import 'dart:convert';
import '../../../../utill/app_constants.dart';
import '../../../base/custom_snackbar.dart';

class ChangeAddressModal extends StatefulWidget {
  final int id;
  final bool isHomeAddress;
  const ChangeAddressModal({Key key, this.id, this.isHomeAddress}) : super(key: key);

  @override
  _ChangeAddressModalState createState() => _ChangeAddressModalState();
}

class _ChangeAddressModalState extends State<ChangeAddressModal> {
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
  String _currentLocation = '';
  List<bool> _isSelected = [false, false];
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: _email);
    _phoneController = TextEditingController(text: _phone);
    _addressController = TextEditingController(text: _address);
    selectedRadioValue = 0;
    getHomeAddressInfo();

  }
  var _email;
  var _phone;
  var _address;
  var _location;
  int pob;
  Future<void> getHomeAddressInfo() async {
    final response = await http.get(Uri.parse(AppConstants.baseUri + AppConstants.customerGetBoxInfoUri+'${widget.id}'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData is List) {
        if (jsonData.isNotEmpty) {
          final carInfo = jsonData[0] as Map<String, dynamic>;

          setState(() {

            if(widget.isHomeAddress==true){

              _email = carInfo['homeEmail'] ?? '';
              _phone = carInfo['homePhone'] ?? '';
              _address = carInfo['homeAddress'] ?? '';
              _location = carInfo['homeLocation'] ?? '';
            }
            else{
              _email = carInfo['officeEmail'] ?? '';
              _phone = carInfo['officePhone'] ?? '';
              _address = carInfo['officeAddress'] ?? '';
              _location = carInfo['officeLocation'] ?? '';
            }

            pob=carInfo['pob'] ?? '';
            _emailController.text=_email;
            _phoneController.text=_phone;
            _addressController.text=_address;
          });
        } else {
          print('Empty  list');
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
      title: const Text('CHANGE VIRTUAL ADDRESS',style: TextStyle(color: Colors.grey,fontSize: 16),),
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
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
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
                      return 'Please enter Email';
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

              const SizedBox(height: 10,),
              Container(
                  decoration: const BoxDecoration(
                    color:Colors.white12,
                  ),
                  child: const Text("By agreeing terms and conditions Our system will automatically update your address to the current location , so make sure you are in the right place.",style: TextStyle(fontSize: 11,color: Colors.redAccent,),)),
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
             const SizedBox(height: 10,),
             _isLoading ? const Center(child: CircularProgressIndicator(),):const SizedBox(),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            print(widget.id);
            setState(() {
              _isLoading=true;
            });
            String randomString = generateRandomString();
            print(randomString);


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
                if(widget.isHomeAddress==true){
                  updateHomeAddress(id:widget.id,email: _emailController.text.toString(),phone: _phoneController.text.toString(),address: _addressController.text.toString(),location: _isChecked ?_currentLocation:_location,homeAddressCode: randomString,isHomeVisible:isVisible);

                }
                else{
                  updateOfficeAddress(id:widget.id,email: _emailController.text.toString(),phone: _phoneController.text.toString(),address: _addressController.text.toString(),location:_isChecked ?_currentLocation:_location,officeAddressCode: randomString,isOfficeVisible: isVisible);

                }

          },
          child: const Text('Save Changes'),
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
      setState(() {
        _isLoading = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return  PobAddress(pob: pob,);
      }));
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
        return  PobAddress(pob: pob,);
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


