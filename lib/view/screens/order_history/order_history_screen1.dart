import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/physical_pob.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/virtual_pob.dart';


class OrderHistoryScreen1 extends StatefulWidget {
  final bool fromMenu;
  const OrderHistoryScreen1({Key key, this.fromMenu = false}) : super(key: key);

  @override
  State<OrderHistoryScreen1> createState() => _OrderHistoryScreen1State();
}

class _OrderHistoryScreen1State extends State<OrderHistoryScreen1> {
  SharedPreferences localStorage;
  bool isCustomerLogin=false;
  @override
  void initState() {
    if(widget.fromMenu){

    }

    super.initState();
    _getLocalData();
  }
  _getLocalData() async {
    localStorage = await SharedPreferences.getInstance();
    isCustomerLogin=localStorage.getBool("isCustomerLogin");
    print(isCustomerLogin);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomRiderAppBar(title:'Manage P.O. Box'.tr),

        body: RefreshIndicator(onRefresh: () async{
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: Column(children: const [



            ],),)
          ],

        )));
  }
}
