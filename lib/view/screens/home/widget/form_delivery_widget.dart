import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/pob_address.dart';
import 'dart:convert';
import '../../../../mobileapi/api.dart';
import '../../../../utill/app_constants.dart';
import '../../../base/custom_snackbar.dart';
import '../home_delivery_request.dart';

class FormDeliveryRequestModal extends StatefulWidget {
  final int id;
  final int amount;
  final int pob;
  final int customerId;
  final int boxId;

  const FormDeliveryRequestModal({Key key,this.id, this.amount, this.pob, this.customerId, this.boxId,}) : super(key: key);

  @override
  _FormDeliveryRequestModalState createState() => _FormDeliveryRequestModalState();
}

class _FormDeliveryRequestModalState extends State<FormDeliveryRequestModal> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _amountFocus = FocusNode();
  bool  _isLoading = false;
  String _selectedPaymentMethod="";
  String _addressType="";
  TextEditingController _amountController;
  int selectedAddressValue;
  @override
  void initState() {
    super.initState();

    _amountController = TextEditingController();
    _amountController.text='${widget.amount}';

    selectedAddressValue = 1;
    print(widget.amount);
    print(widget.pob);
    print(widget.id);
    print(widget.boxId);

  }
  var _amount;
  int pob;

  setSelectedAddressValue(int value) {
    setState(() {
      selectedAddressValue = value;
      print(selectedAddressValue);
    });
  }
  int selectedValue;

  void _handleRadioValueChange(int value) {
    setState(() {
      selectedValue = value;
      print(selectedValue);

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
  DateTime selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('HOME DELIVERY REQUEST',style: TextStyle(color: Colors.grey,fontSize: 16),),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5,),
              const Text("Choose delivery Address",style: TextStyle(fontSize: 18),),
              const SizedBox(height: 5,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Radio<int>(
                          value: 1,
                          groupValue: selectedAddressValue,
                          onChanged: setSelectedAddressValue,
                        ),
                        const Text('Home'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<int>(
                          value: 2,
                          groupValue: selectedAddressValue,
                          onChanged: setSelectedAddressValue,
                        ),
                        const Text('Office'),
                      ],
                    ),
                  ],
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
                child: InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedDate != null
                              ? selectedDate.toString().split(' ')[0]
                              : 'Expected Delivery Date',
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
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
                  controller: _amountController,
                  focusNode: _amountFocus,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Amount',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 10.0,
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Amount required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                  },
                  // Rest of your TextFormField properties
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Choose payment method",style: TextStyle(fontSize: 18),),
              const SizedBox(height: 5,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Radio<int>(
                          value: 1,
                          groupValue: selectedValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        const Text('Cash'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<int>(
                          value: 2,
                          groupValue: selectedValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        const Text('Momo Pay'),
                      ],
                    ),
                  ],
                ),
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
            print(widget.boxId);
            print(widget.customerId);
            print(widget.pob);
            print(_selectedPaymentMethod);
            print(_addressType);
            print(widget.amount);

            setState(() {
              _isLoading=true;
            });
            if(selectedAddressValue==1){
              _addressType="Home";
            }
            else{
              _addressType="Office";
            }
            if(selectedValue==1){
              _selectedPaymentMethod="Cash on Delivery";
            }
            else{
              _selectedPaymentMethod="MoMo Pay";
            }
            _saveHomeDeliveryRequest();

          },
          child: const Text('Request Delivery'),
        ),
      ],
    );
  }
  void _saveHomeDeliveryRequest() async {
    setState(() {
      _isLoading = true;
    });
    String expectedDelivery = DateFormat('yyyy-MM-dd').format(selectedDate);

    var data = {
      'inboxing':widget.id,
      'pob': widget.pob,
      'amount': widget.amount,
      'customer_id':widget.customerId,
      'box_id':widget.boxId,
      'addressOfDelivery':_addressType,
      'expectedDateOfDelivery':expectedDelivery,
      'paymentMethod':_selectedPaymentMethod,
    };

    var res = await CallApi().postData(data, AppConstants.saveHomeDeliveryUri);
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
          msg: "Home delivery request received successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        setState(() {
          _isLoading = false;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return const HomeDeliveryRequest();
        }));

      } else {
        setState(() {
          _isLoading = false;
        });
        showCustomSnackBar('Failed to submit request'.tr);

      }
    }
  }

}


