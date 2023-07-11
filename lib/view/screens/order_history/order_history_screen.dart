import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/widget/order_history_header_widget.dart';
import 'package:http/http.dart' as http;
import '../../../utill/app_constants.dart';
import '../mails/approved_mails.dart';
import '../mails/international_mails.dart';
import '../mails/national_mails.dart';

class OrderHistoryScreen extends StatefulWidget {
  final bool fromMenu;
  const OrderHistoryScreen({Key key, this.fromMenu = false}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  SharedPreferences localStorage;
  bool isCustomerLogin = false;

  @override
  void initState() {
    if (widget.fromMenu) {}

    super.initState();
    _getLocalData();
  }

  int rowCount = 0;
  int numberNat = 0;
  int numberInt = 0;
  var userId;
  var userData;

  _getLocalData() async {
    localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString("user");
    var user = json.decode(userJson);
    setState(() {
      userId = user['id'];
    });
    nationalMails();
    internationalMails();
  }

  Future<void> nationalMails() async {
    final response =
    await http.get(Uri.parse(AppConstants.baseUri + AppConstants.getNationalMailUri + '$userId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        numberNat = data['count'];
        print(numberNat);
      });
    } else {
      // Handle error
    }
  }

  Future<void> internationalMails() async {
    final response =
    await http.get(Uri.parse(AppConstants.baseUri + AppConstants.getInternationalMailUri + '$userId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        numberInt = data['count'];
        print(numberInt);
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomRiderAppBar(title: 'Approved Mail History'),
      body: RefreshIndicator(
        onRefresh: () async {
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height*01, // Adjust the height according to your needs
                child: Column(
                  children: const [
                    Expanded(
                      child: ApprovedInternationalMail(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
