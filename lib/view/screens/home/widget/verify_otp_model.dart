import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../mobileapi/api.dart';
import '../../../../utill/app_constants.dart';
import '../../../base/custom_snackbar.dart';
import '../driver_home_delivery.dart';

class VerifyOtpModal extends StatefulWidget {
  final int id;
  final int otp;
  final int inboxing;
  const  VerifyOtpModal({Key key, this.id, this.otp, this.inboxing}) : super(key: key);
  @override
  _VerifyOtpModalState createState() => _VerifyOtpModalState();
}
class _VerifyOtpModalState extends State<VerifyOtpModal> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode otpFocus = FocusNode();
  bool  _isLoading = false;

  TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('SECURITY CODE CHECK UP',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 14),),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const Text('To deliver mail to customer, he/she must you security code to verify if the belongs to that customer',style: TextStyle(color: Colors.blueGrey,fontSize: 12),),
            const SizedBox(height: 10,),
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
                controller: _otpController,
                obscureText: true,
                focusNode: otpFocus,
                autocorrect: true,
                maxLength: 6,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Verify Security Code...',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 10.0,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter otp';
                  }
                  if(value.length!=6){
                    return 'OTP should be 6 digits';
                  }
                  return null;
                },
                onSaved: (value) {
                },
                // Rest of your TextFormField properties
              ),
            ),
            const SizedBox(height: 20,),

          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            print(widget.id);
            print(widget.inboxing);
            print(widget.otp);

            if(_formKey.currentState.validate()){
              int otp=int.parse(_otpController.text);
              int inboxId=widget.inboxing;
              int correctOtp=widget.otp;
              int id=widget.id;
              if(correctOtp==otp){
                verifyOtp(id:id,inboxing: inboxId );
              }
              else{
                showCustomSnackBar('Invalid security, double check customer security  code'.tr);

              }
            }
            else{
              return;
            }

          },
          child: const Text('Verify'),
        ),
      ],
    );
  }
  Future<void> verifyOtp({int id,int inboxing}) async {
    final url = AppConstants.baseUri+AppConstants.driverDeliverMailUri+'$id';

    final response = await http.put(
      Uri.parse(url),
      body: {
         'id': id.toString(),
         'inboxing':inboxing.toString(),
      },
    );
    if (response.statusCode == 200) {
      // Customer updated successfully
      Fluttertoast.showToast(
        msg: " Mail Delivered !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context){
       return const DriverHomeDeliveryRequest(); 
      }));
    } else {
      // Error occurred during the update
      print('Error updating customer: ${response.body}');
      setState(() {
        _isLoading = false;
      });
      showCustomSnackBar('Failed to save'.tr);
    }
  }


}


