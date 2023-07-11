import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/view/screens/home/widget/verify_otp_model.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/pob_info.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/widget/add_address_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/widget/change_address_widget.dart';

import '../../../utill/app_constants.dart';
import '../../base/custom_home_app_bar.dart';
import '../../base/no_data_screen.dart';
import '../home/widget/view_on_map.dart';

class DriverHomeDeliveryRequest extends StatefulWidget {

  const DriverHomeDeliveryRequest({Key key}) : super(key: key);

  @override
  State<DriverHomeDeliveryRequest> createState() => _DriverHomeDeliveryRequestState();
}

class _DriverHomeDeliveryRequestState extends State<DriverHomeDeliveryRequest> {
  bool _loading = false;
  List<dynamic> _listPob = [];
  SharedPreferences localStorage;

  var userId;
  void _getUserInfo() async {
 localStorage = await SharedPreferences.getInstance();
    var userJson=localStorage.getString("user");
    var user=json.decode(userJson);
    print(user['id']);
    setState(() {
      userId=user['id'];
    });
 loadDriverRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRiderAppBar(title:'DRIVER HOME DELIVERY HISTORY'.tr,isBack:true),
      body: _loading ? const Center(child: CircularProgressIndicator()):_listPob.isNotEmpty
          ? ListView.builder(
        itemCount: _listPob.length,
        itemBuilder: ((context, index) {
          final courierList = _listPob[index];
          final courier = courierList['curier'];
          final box=courierList['box'];
          final homeLocation=box['homeLocation'];
          final officeLocation=box['officeLocation'];


            return Card(
              elevation: 10,
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              child: Container(
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Theme.of(context).primaryColor, // Set the border color here
                //     width: 2.0, // Set the border width here
                //   ),
                // ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5,),
                        Text("Delivery Address: ${_listPob[index]['addressOfDelivery']}",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 5,),
                        Text("Customer Name: ${courier['inname']}",style: const TextStyle(fontSize: 16,)),
                        const SizedBox(height: 5,),

                        Text("Mail Number: ${courier['innumber']}",style: const TextStyle()),
                        const SizedBox(height: 5,),
                        Text("Tracking Number: ${courier['intracking']}",style: const TextStyle()),
                        const SizedBox(height: 5,),
                        _listPob[index]['addressOfDelivery']=="home"? Text("Home Address: ${box['homeAddress']}"):Text("Office Address: ${box['homeAddress']}"),
                        const SizedBox(height: 5,),
                        _listPob[index]['addressOfDelivery']=="home"? Text("Home Phone: ${box['homePhone']}",style: const TextStyle(),):Text("Office Phone: ${box['officePhone']}",style: const TextStyle(),),
                        const SizedBox(height: 5,),
                        _listPob[index]['addressOfDelivery']=="home"? Text("Home Email: ${box['homeEmail']}",style: const TextStyle(),):Text("Office Email: ${box['officeEmail']}",style: const TextStyle(),),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("View address on map",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 14),),
                            IconButton(onPressed: (){
                              if(_listPob[index]['addressOfDelivery']=="home"){
                                List<String> coordinates = homeLocation.split(
                                    ',');

                                double latitude = double.parse(coordinates[0]);
                                double longitude = double.parse(coordinates[1]);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CustomMapWidget(latitude: latitude,
                                          longitude: longitude,
                                          title: "Home Address Location",),
                                  ),
                                );
                              }
                              else {
                                List<String> coordinates = officeLocation.split(
                                    ',');

                                double latitude = double.parse(coordinates[0]);
                                double longitude = double.parse(coordinates[1]);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CustomMapWidget(latitude: latitude,
                                          longitude: longitude,
                                          title: "Office Address Location",),
                                  ),
                                );
                              }  //open in map
                            }, icon: Icon(
                              Icons.location_on_outlined,
                              color:Theme.of(context).primaryColor,
                              size: 30,
                            )),
                            _listPob[index]['status']==2?Text("Deliver Mail",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 14),):Text("Delivered",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 14),),

                            _listPob[index]['status']==2?IconButton(onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return VerifyOtpModal(id: _listPob[index]['id'],otp: _listPob[index]['code'],inboxing: _listPob[index]['inboxing'],);
                                },
                              );

                            }, icon: Icon(
                              Icons.delivery_dining_outlined,
                              color:Theme.of(context).primaryColor,
                              size: 30,
                            )):IconButton(onPressed: () async {
                            }, icon: Icon(
                              Icons.check_box,
                              color:Theme.of(context).primaryColor,
                              size: 30,
                            )),
                          ],
                        ),



                      ],
                    )
                ),
              ),

            );




        }),
      ) : const Center(child: NoDataScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();


  }

  loadDriverRequest() async {
    setState(() {
      _loading = true;
    });

    var res = await http.get(Uri.parse(AppConstants.baseUri+AppConstants.driverHomeRequestUri+'$userId'));
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




























































