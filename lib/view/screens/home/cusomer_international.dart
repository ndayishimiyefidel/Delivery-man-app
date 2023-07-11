import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/view/screens/home/widget/form_delivery_widget.dart';

import '../../../utill/app_constants.dart';
import '../../base/custom_home_app_bar.dart';
import '../../base/no_data_screen.dart';

class CustomerInternationalMails extends StatefulWidget {
  const CustomerInternationalMails({Key key}) : super(key: key);
  @override
  State<CustomerInternationalMails> createState() => _CustomerInternationalMailsState();
}

class _CustomerInternationalMailsState extends State<CustomerInternationalMails> {
  bool _loading = false;

  final GlobalKey<ScaffoldState> _scaffoldkey =  GlobalKey<ScaffoldState>();
  List<dynamic> _customerInternationalMails = [];
  SharedPreferences localStorage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldkey,
      appBar: CustomRiderAppBar(title: 'Manage Your Mails'.tr, isSwitch: true,isBack: true,),
      body:_loading
          ? const Center(child: CircularProgressIndicator())
          : _customerInternationalMails.isNotEmpty
          ? ListView.builder(
        itemCount: _customerInternationalMails.length,
        itemBuilder: ((context, index) {
          final branchesList = _customerInternationalMails[index];
          final branch = branchesList['branch'];
            return Card(
              color: Colors.white24,
              elevation:5,
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("P.O. Box  ${_customerInternationalMails[index]['pob']} ${branch['name']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Theme.of(context).primaryColor),),
                      const SizedBox(height: 5,),
                      Text("Mail Number: ${_customerInternationalMails[index]['innumber']}"),
                      const SizedBox(height: 5,),
                      Text("Mail type: ${_customerInternationalMails[index]['mailtype']}",style: const TextStyle(),),
                      const SizedBox(height: 5,),
                      Text("Tracking Number: ${_customerInternationalMails[index]['intracking']}"),
                      const SizedBox(height: 5,),
                      Text("Amount :${_customerInternationalMails[index]['amount']}",style: const TextStyle(fontWeight: FontWeight.bold,),),
                      const SizedBox(height: 5,),
                      _customerInternationalMails[index]['instatus']!='6'? _customerInternationalMails[index]['instatus']=='3'? TextButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return FormDeliveryRequestModal(id: _customerInternationalMails[index]['id'],pob: _customerInternationalMails[index]['pob'],amount: _customerInternationalMails[index]['amount'],boxId: _customerInternationalMails[index]['pob_bid'],customerId: _customerInternationalMails[index]['customer_id'],);
                            },
                          );
                        },
                        label: const Text("Request Home Delivery"),
                        icon: const Icon(Icons.location_on_outlined, size: 25),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          )),
                          textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 22)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ): Row(
                        children: [
                          Icon(Icons.check_outlined,size: 20,color: Theme.of(context).primaryColor),
                          Text("DELIVERED",style: TextStyle(color: Theme.of(context).primaryColor),),
                        ],
                      ): Row(
                        children: [
                          Icon(Icons.pending_actions_outlined,size: 20,color: Theme.of(context).primaryColor),
                          Text("PENDING",style: TextStyle(color: Theme.of(context).primaryColor),),
                        ],
                      ),
                    ],
                  )
              ),
            );
        }),
      ) : const Center(child: NoDataScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    loadPoxList();

  }

  loadPoxList() async {
    setState(() {
      _loading = true;
    });
    localStorage= await SharedPreferences.getInstance();
    var userJson=localStorage.getString("user");
    var user = json.decode(userJson);
    var loggedInUserId=user['id'];

    var res = await http.get(Uri.parse(AppConstants.baseUri+AppConstants.customerInternationalUri+'$loggedInUserId'));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      print(jsonData);
      if (jsonData['data'].isNotEmpty) {
        setState(() {
          _customerInternationalMails = jsonData['data'];

        });
      }
      setState(() {
        _loading = false;
      });
    }
  }
}



























































