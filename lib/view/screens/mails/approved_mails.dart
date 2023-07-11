import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../utill/app_constants.dart';
import '../../base/no_data_screen.dart';

class ApprovedInternationalMail extends StatefulWidget {
  const ApprovedInternationalMail({Key key}) : super(key: key);

  @override
  State<ApprovedInternationalMail> createState() => _ApprovedInternationalMailState();
}

class _ApprovedInternationalMailState extends State<ApprovedInternationalMail> {
  bool _loading = false;
  List<dynamic> _driverMails = [];
  SharedPreferences localStorage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

         !_loading ? _buildContent(): _buildLoadingIndicator(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return _driverMails.isNotEmpty
        ? ListView.builder(
      itemCount: _driverMails.length,
      itemBuilder: ((context, index) {
        return Card(
          elevation: 10,
          shadowColor: Theme.of(context).primaryColor,
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
                      "Dispatch Number: " + _driverMails[index]['dispatchNumber'],
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
                      "Gross Weight: ${_driverMails[index]['grossweight']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Dispatch Type: ${_driverMails[index]['dispachetype']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Center(
                  child: Text(
                    "Approved",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    )
        : const Center(child: NoDataScreen());
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
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
        AppConstants.baseUri + AppConstants.getDriverApprovedInternationalMailUri+'$loggedInUserId'));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      print(jsonData);
      if (jsonData['data'].isNotEmpty) {
        setState(() {
          _driverMails = jsonData['data'];
        });
      }
      setState(() {
        _loading = false;
      });
    }
  }
}
