import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/view/screens/applications/poxbox_appplication.dart';
import 'package:sixvalley_delivery_boy/view/screens/applications/poxbox_renewe.dart';
import '../../base/custom_home_app_bar.dart';
class ConversationScreen1 extends StatefulWidget {
  const ConversationScreen1({Key key}) : super(key: key);

  @override
  State<ConversationScreen1> createState() => _ConversationScreen1State();
}

class _ConversationScreen1State extends State<ConversationScreen1> {
  SharedPreferences localStorage;
  bool isCustomerLogin=false;


  @override
  void initState() {
    super.initState();
    _getLocalData();
  }
  _getLocalData() async {
    localStorage = await SharedPreferences.getInstance();
    //make sure customer is logged in
    isCustomerLogin=localStorage.getBool("isCustomerLogin");
    print(isCustomerLogin);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRiderAppBar(title:  'Pox Box Applications'.tr),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DefaultTabController(
              length: 2, // length of tabs
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black26,
                      indicatorColor: Colors.black,
                      tabs: [
                        Tab(text: 'New Pox Box'),
                        Tab(text: 'Existing'),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height *
                        0.76, //height of TabBarView
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: const TabBarView(
                      children: <Widget>[
                        PhysicalPoxBoxApplication(),
                       PoxRenew(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

