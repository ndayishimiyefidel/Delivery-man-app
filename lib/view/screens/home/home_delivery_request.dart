import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/view/screens/home/widget/form_delivery_widget.dart';

import '../../../utill/app_constants.dart';
import '../../base/custom_home_app_bar.dart';
import '../../base/no_data_screen.dart';
import 'cusomer_international.dart';

class HomeDeliveryRequest extends StatefulWidget {
  const HomeDeliveryRequest({Key key}) : super(key: key);

  @override
  State<HomeDeliveryRequest> createState() => _HomeDeliveryRequestState();
}

class _HomeDeliveryRequestState extends State<HomeDeliveryRequest> {
  bool _loading = false;

  final GlobalKey<ScaffoldState> _scaffoldkey =  GlobalKey<ScaffoldState>();
  List<dynamic> _homeDelivery = [];
  SharedPreferences localStorage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      key: _scaffoldkey,
      appBar: CustomRiderAppBar(title: 'HOME DELIVERY REQUEST HISTORY'.tr, isSwitch:false,isBack: true,),
      body:_loading
          ? const Center(child: CircularProgressIndicator())
          : _homeDelivery.isNotEmpty
          ? SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return  const CustomerInternationalMails();
                      }));
                    },
                    label: const Text("ADD NEW ",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),),
                    icon: const Icon(Icons.add, size: 30),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 3,
                      )),
                      textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 16)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                // const Text("HOME P.O. BOX  DELIVERY REQUEST HISTORY",textAlign: TextAlign.start,),
                // SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                ListView.builder(
        itemCount: _homeDelivery.length,
                  shrinkWrap: true,
        itemBuilder: ((context, index) {
          final delivery = _homeDelivery[index];
          final branch = delivery['branch'];
          final homeDelivery = delivery['home_delivery'];
          return Card(
            color: Colors.white24,
            elevation: 5,
            margin: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("P.O. Box  ${_homeDelivery[index]['pob']}  ${branch['name']}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor)),
                  const SizedBox(height: 5,),
                  Text("Names : ${_homeDelivery[index]['inname']}"),
                  const SizedBox(height: 5,),
                  Text("Phone: ${_homeDelivery[index]['phone']}",
                      style: const TextStyle()),
                  const SizedBox(height: 5,),
                  Text("Mail Number: ${_homeDelivery[index]['innumber']}"),
                  const SizedBox(height: 5,),
                  Text("Paid Amount :${homeDelivery[0]['amount']}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5,),
                  Text("Address of Delivery :${homeDelivery[0]['addressOfDelivery']}",
                      style: const TextStyle(fontWeight: FontWeight.normal)),
                  const SizedBox(height: 5,),
                  homeDelivery[0]['code']==null?const SizedBox():Text("Security Code :${homeDelivery[0]['code']}",
                      style: const TextStyle(fontWeight: FontWeight.normal)),
                  const SizedBox(height: 5,),
                  homeDelivery[0]['status'] != 4
                      ? homeDelivery[0]['status'] != 0
                      ? _homeDelivery[index]['status'] == 1
                      ? const Text("UNPAID")
                      : const Text("PAID")
                      : const Text(
                    "PENDING",
                    style: TextStyle(color: Colors.redAccent),
                  )
                      : const Text("DELIVERED"),
                ],
              ),
            ),
          );
        }),
      ),
              ],
            ),
          ) : const Center(child: NoDataScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadDeliveryList();

  }

  _loadDeliveryList() async {
    setState(() {
      _loading = true;
    });
    localStorage= await SharedPreferences.getInstance();
    var userJson=localStorage.getString("user");
    var user = json.decode(userJson);
    var loggedInUserId=user['id'];

    var res = await http.get(Uri.parse(AppConstants.baseUri+AppConstants.customerDeliveryUri+'$loggedInUserId'));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      print(jsonData);
      if (jsonData['data'].isNotEmpty) {
        setState(() {
          _homeDelivery = jsonData['data'];

        });
      }
      setState(() {
        _loading = false;
      });
    }
  }
}



























































