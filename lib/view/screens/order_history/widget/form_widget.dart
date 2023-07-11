import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../mobileapi/api.dart';
import '../../../../utill/app_constants.dart';
import '../../../base/custom_snackbar.dart';

class MyFormModal extends StatefulWidget {
  final int id;
  const MyFormModal({Key key, this.id}) : super(key: key);

  @override
  _MyFormModalState createState() => _MyFormModalState();
}

class _MyFormModalState extends State<MyFormModal> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _kilometrageFocus = FocusNode();
  bool  _isLoading = false;

  TextEditingController _kilometrageController;

  @override
  void initState() {
    super.initState();
    _kilometrageController = TextEditingController();
  }
  // Define variables for form fields
  String _name = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('SAVE TIME IN',style: TextStyle(color: Colors.grey),),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                controller: _kilometrageController,
                focusNode: _kilometrageFocus,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Kilometrage In',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 10.0,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter kilometrage in';
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
            final DateTime now = DateTime.now();
              final String timeIn='${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
            updateDriverRoute(id:widget.id,time: timeIn,km_in: _kilometrageController.text.toString());
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
  Future<void> updateDriverRoute({int id, String time, String km_in}) async {
    final url = AppConstants.baseUri+AppConstants.driverUpdateRouteUri+'$id';

    final response = await http.put(
      Uri.parse(url),
      body: {
            'km_in': km_in,
            'datetimeIn':time,
      },
    );
    if (response.statusCode == 200) {
      // Customer updated successfully
            Fluttertoast.showToast(
              msg: " Saved successfully!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
            Navigator.pop(context);
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


