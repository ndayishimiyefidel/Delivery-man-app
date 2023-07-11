import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/pob_address.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/pob_info.dart';

import '../../../utill/app_constants.dart';
import '../../base/custom_home_app_bar.dart';
import '../../base/no_data_screen.dart';

class PhysicalPob extends StatefulWidget {
  const PhysicalPob({Key key}) : super(key: key);

  @override
  State<PhysicalPob> createState() => _PhysicalPobState();
}

class _PhysicalPobState extends State<PhysicalPob> {
  final GlobalKey<ScaffoldState> _scaffoldkey =  GlobalKey<ScaffoldState>();
  bool _loading = false;
  List<dynamic> _listPob = [];
  SharedPreferences localStorage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: CustomRiderAppBar(title: 'Manage P.O Box'.tr, isSwitch: true,isBack: true,),
      body:_loading ?const Center(child: CircularProgressIndicator()) :_listPob.isNotEmpty
          ? ListView.builder(
        itemCount: _listPob.length,
        itemBuilder: ((context, index) {
          final branchesList = _listPob[index];
          final branch = branchesList['branch'];
            return Card(
              // color: Colors.white24,
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
                      Text("P.O. Box ${_listPob[index]['pob']} ${branch['name']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Theme.of(context).primaryColor),),
                      const SizedBox(height: 5,),
                      Text("P.O. Box Category: ${_listPob[index]['pob_category']}"),
                      const SizedBox(height: 5,),
                      Text("Owner Name: "+_listPob[index]['name'],style: const TextStyle(),),
                      const SizedBox(height: 5,),
                      Text("phone Number: ${_listPob[index]['phone']}"),
                      const SizedBox(height: 5,),
                      Text("Payment Amount: ${_listPob[index]['amount']}"),
                      const SizedBox(height: 5,),
                      Text("status: ${_listPob[index]['status']} and  ${_listPob[index]['approoved']==0?"Pending":"Approved"}",style:  TextStyle(color: Theme.of(context).primaryColor,fontSize: 16,),),
                      const SizedBox(height: 5,),
                      _listPob[index]['approoved']==1?
                      TextButton.icon(
                        onPressed: () {
                          // Respond to button press
                          print("Home delivery");
                        },
                        label: const Text("Edit P.O. Box"),
                        icon: const Icon(Icons.edit_outlined, size: 20),
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
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ): Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                             // print(_listPob[index]['pob']);
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return PobInfo(pob: _listPob[index]['pob'],amount: _listPob[index]['amount'],year: _listPob[index]['year'],id: _listPob[index]['id'],bid:_listPob[index]['branch_id'],name: _listPob[index]['name'],serviceType: _listPob[index]['serviceType'],);
                            }
                            ));
                            },
                            label: const Text("P.O. Box Info"),
                            icon: const Icon(Icons.info_outline_rounded, size: 20),
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
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {

                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return PobAddress(pob: _listPob[index]['pob'],);
                              }
                              ));
                            },
                            label: const Text("Virtual Address"),
                            icon: const Icon(Icons.location_on_outlined, size: 20),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                                horizontal: 3,
                                vertical: 3,
                              )),
                              textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 16)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
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
  //  print(loggedInUserId);

    var res = await http.get(Uri.parse(AppConstants.baseUri+AppConstants.customerPhysicalPobUri+'$loggedInUserId'));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      print(jsonData);
      if (jsonData['data'].isNotEmpty) {
        setState(() {
          _listPob = jsonData['data'];

        });
      }
      setState(() {
        _loading = false;
      });
    }
  }
}



























































