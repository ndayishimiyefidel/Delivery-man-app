import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../utill/app_constants.dart';
import '../../base/custom_home_app_bar.dart';
import '../../base/no_data_screen.dart';

class InternationalMail extends StatefulWidget {
  const InternationalMail({Key key}) : super(key: key);

  @override
  State<InternationalMail> createState() => _InternationalMailState();
}

class _InternationalMailState extends State<InternationalMail> {
  bool _loading = false;
  List<dynamic> _driverMails = [];
  SharedPreferences localStorage;
  List<bool> _isCheckedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRiderAppBar(title: 'PICK EMS MAIL AT AIRPORT'.tr, isSwitch: false,isBack: true,),
      body: Stack(
        children: [
          Visibility(
            visible: _loading,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          _driverMails.isNotEmpty
              ? ListView.builder(
            itemCount: _driverMails.length,
            itemBuilder: ((context, index) {
                return Card(
                  shadowColor: Theme.of(context).primaryColor,
                  color: Colors.white38,
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
                              "Dispatch Number: " +
                                  _driverMails[index]['dispatchNumber'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Item Number: ${_driverMails[index]['numberitem']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Gross Weight: ${_driverMails[index]['grossweight']}",style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Dispatch Type: ${_driverMails[index]['dispachetype']}",style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                            ),
                          ],
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              bool confirm = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirmation',style: TextStyle(fontSize: 16),),
                                    content: const Text('Are you sure you want to approve this mail ?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(true),
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  );
                                },
                              );

                                if(confirm==true){
                                  setState(() {
                                    _loading = true;
                                  });
                                  print(_driverMails[index]['id']);
                                  var res = await http.put(Uri.parse(
                                      AppConstants.baseUri +
                                          AppConstants.getUpdateUri +
                                          '${_driverMails[index]['id']}'));
                                  if (res.statusCode == 200) {
                                    print('updated successfully');
                                    setState(() {
                                      _loading = false;
                                      _isCheckedList[index] =
                                      !_isCheckedList[index];
                                    });
                                    showSuccessDialog(); // Show success dialog
                                    loadDriverInternationalMailList(); // Refresh the UI
                                  }
                                }

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.grey[100],
                                border: Border.all(
                                  color: _isCheckedList[index]
                                      ? Colors.blue
                                      : Colors.grey,
                                  width: 2.0,
                                ),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: _isCheckedList[index]
                                  ? const Icon(
                                Icons.check,
                                color: Colors.blue,
                              )
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );

            }),
          )
              : Visibility(
            visible: !_loading,
            child: const NoDataScreen(),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadDriverInternationalMailList();
  }

  loadDriverInternationalMailList() async {
    setState(() {
      _loading = true;
    });
    print("hello");
    localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString("user");
    var user = json.decode(userJson);
    var loggedInUserId = user['id'];
    print(loggedInUserId);
    var res = await http.get(Uri.parse(
        AppConstants.baseUri + AppConstants.getAssignedDriverNationalMailUri+'$loggedInUserId'));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      print(jsonData);
      if (jsonData['data'].isNotEmpty) {
        setState(() {
          _driverMails = jsonData['data'];
          _isCheckedList = List.generate(_driverMails.length, (_) => false);

        });
      }
      setState(() {
        _loading = false;
      });
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Driver Mail Approval'),
          content: const Text('Approved successfully.'),
          actions: [
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
