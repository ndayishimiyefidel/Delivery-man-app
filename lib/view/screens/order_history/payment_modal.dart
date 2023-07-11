import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/pob_address.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/pob_info.dart';
import 'dart:convert';
import '../../../../mobileapi/api.dart';
import '../../../../utill/app_constants.dart';
import '../../base/custom_snackbar.dart';


class PaymentModal extends StatefulWidget {
  final int id;
  final double amount;
  final int pob;
  final int bid;
  final int boxId;
  final String name;
  final String serviceType;
  final int lastPaidYear;
  final int numberYear;


  const PaymentModal({Key key, this.numberYear,this.serviceType,this.name,this.id, this.amount, this.pob, this.bid, this.boxId, this.lastPaidYear,}) : super(key: key);

  @override
  _PaymentModalState createState() => _PaymentModalState();
}

class _PaymentModalState extends State<PaymentModal> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _amountFocus = FocusNode();
  bool  _isLoading = false;
  String paymentType;
  String paymentModel;
  int selectedPaymentYear;
  List<String> paymentTypeOptions = ['Certificate', 'Cotion','Rent','Ingufuri'];
  List<String> paymentOptions = ['Mobile Money', 'Bank Account','Cash In Hand'];
  // List<String> paymentYearOptions = ['2020', '2021','2022','2023','2024','2025'];


  TextEditingController _amountController;
  TextEditingController _nameController;
  List<int> paymentYearOptions=[];


double rentAmount=0.0;
  // Get the current year
  int currentYear = DateTime.now().year;
  @override
  void initState() {
    super.initState();
    print("branchid");
    print(widget.bid);
    print("ids");
    print(widget.id);
    print("service type");
    print(widget.serviceType);
    print(widget.lastPaidYear);
    print("rent year");
    print(widget.numberYear);

    _amountController = TextEditingController();
    _nameController = TextEditingController();
    rentAmount=widget.amount/widget.numberYear;
    _amountController.text=rentAmount.toString();
    _nameController.text=widget.name;
    generateRandomString();



// Calculate the range of years 2023
    int startYear = widget.lastPaidYear+1; // Replace with your specific year
    paymentYearOptions = List.generate((currentYear - startYear)+5, (index) => startYear + index);


  }
  String randomString = '';
  String generateRandomString() {
    String capitals = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String numbers = '0123456789';
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
      title: const Text('P.O BOX PAYMENT',style: TextStyle(color: Colors.grey,fontSize: 16),),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: _nameController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'name',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 10.0,
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'name';
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
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)
                  ),
                  value: paymentModel ?? null,
                  hint: const Text('Select Payment Method'),
                  items: paymentOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      paymentModel = newValue;
                    });
                  },
                ),
              )
              ,
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
                    border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10)
                  ),
                  value: paymentType ?? null,
                  hint: const Text('Select Payment Type'),
                  items: paymentTypeOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      paymentType = newValue;
                      double certPay=5000.0;
                      double cotionPay=11000.0;
                      if(paymentType=="Ingufuri"){
                        _amountController.text=certPay.toString();
                      }
                      else if(paymentType=="Certificate"){
                        _amountController.text=certPay.toString();
                      }
                      else if(paymentType=="Cotion"){
                        _amountController.text=cotionPay.toString();
                      }
                      else if(paymentType=="Rent"){
                        _amountController.text=rentAmount.toString();
                      }
                    });
                  },
                ),
              ),
              const SizedBox(height: 20,),
              paymentType=="Rent"? Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child:  DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10)
                  ),
                  value: selectedPaymentYear,
                  hint: const Text('Select Payment Year'),
                  items: paymentYearOptions.map((year) {
                    return DropdownMenuItem<int>(
                      value: year,
                      child: Text(year.toString()),
                    );
                  }).toList(),
                  onChanged: (int newValue) {
                    setState(() {
                      selectedPaymentYear = newValue; // Update the selected year
                    });
                  },
                ),
              ):const SizedBox(),
              const SizedBox(height: 20,),
             paymentType!=null? Container(
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
                  enabled: false,
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
              ):SizedBox(),
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
            print(paymentType);

            if(selectedPaymentYear==widget.lastPaidYear+1 && paymentType=="Rent"){
              _savePobPayment();

            }
            else if(paymentType!="Rent"){
              _savePobPayment();
            }

            else{
              showCustomSnackBar('You cannot pay the next year without paying the previous'.tr);
              setState(() {
                _isLoading=false;
              });

            }

          },
          child: const Text('Pay now'),
        ),
      ],
    );
  }
  void _savePobPayment() async {
    setState(() {
      _isLoading = true;
    });
   double amount=double.parse(_amountController.text);
    var data = {
      'box_id':widget.id,
      'year': paymentType=="Rent"?selectedPaymentYear:currentYear,
      'bid':widget.bid,
      'amount':amount,
      'payment_type':paymentType=="Certificate"?"cert":paymentType,
      'payment_model':paymentModel,
      'payment_ref':randomString,
      'serviceType':widget.serviceType,
    };

    var res = await CallApi().postData(data, AppConstants.savePaymentUri);
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
          msg: "payment successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        // Navigator.push(context, MaterialPageRoute(builder: (context){
        //   return const PobAddress();
        // }));
        Navigator.pop(context);

        setState(() {
          _isLoading = false;
        });

      } else {
        setState(() {
          _isLoading = false;
        });
        showCustomSnackBar('Failed to submit request'.tr);

      }
    }
  }

}


