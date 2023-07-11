import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/widget/add_address_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/widget/change_address_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utill/app_constants.dart';
import '../../base/custom_home_app_bar.dart';
import '../../base/no_data_screen.dart';
import '../home/widget/view_on_map.dart';

class CustomerVirtualAddress extends StatefulWidget {
  const CustomerVirtualAddress({Key key,}) : super(key: key);

  @override
  State<CustomerVirtualAddress> createState() => _CustomerVirtualAddressState();
}

class _CustomerVirtualAddressState extends State<CustomerVirtualAddress> {
  bool _loading = false;
  List<dynamic> _listPob = [];
  SharedPreferences localStorage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRiderAppBar(title:'VIRTUAL ADDRESS'.tr,isBack:true),
      body: _loading ? const Center(child: CircularProgressIndicator()):_listPob.isNotEmpty
          ? ListView.builder(
        itemCount: _listPob.length,
        itemBuilder: ((context, index) {
          if(_listPob[index]['hasAddress']==1){
            String officeLocation=_listPob[index]["officeLocation"];
            String homeLocation=_listPob[index]["homeLocation"];
            final branchesList = _listPob[index];
            final branch = branchesList['branch'];


            return Card(
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

                      Text("P.O. Box ${_listPob[index]['pob']}  ${branch['name']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Theme.of(context).primaryColor),),
                      _listPob[index]['homeLocation']!=null? Text("HOME ADDRESS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Theme.of(context).primaryColor),):const SizedBox(),
                      _listPob[index]['homeLocation']!=null? const SizedBox(height: 5,):const SizedBox(),

                      _listPob[index]['homeEmail']!=null? Text("${_listPob[index]['homeEmail']}",style: const TextStyle(fontSize: 16,)):const SizedBox(),
                      _listPob[index]['homeLocation']!=null? const SizedBox(height: 5,):const SizedBox(),
                      _listPob[index]['homeAddress']!=null? Text(" ${_listPob[index]['homeAddress']}"):const SizedBox(),
                      _listPob[index]['homeLocation']!=null? const SizedBox(height: 5,):const SizedBox(),
                      _listPob[index]['homePhone']!=null? Text(_listPob[index]['homePhone'],style: const TextStyle(),):const SizedBox(),
                      _listPob[index]['homePhone']!=null?const SizedBox(height: 10,):const SizedBox(),
                      // _listPob[index]['homeLocation']!=null?
                      // Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     GestureDetector(onTap:(){
                      //       List<String> coordinates = homeLocation.split(',');
                      //
                      //       double latitude = double.parse(coordinates[0]);
                      //       double longitude = double.parse(coordinates[1]);
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => CustomMapWidget(latitude: latitude, longitude: longitude,title: "My Home Address",),
                      //         ),
                      //       );
                      //     },child: Text("View on map",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 14),)),
                      //     IconButton(onPressed: (){
                      //       List<String> coordinates = homeLocation.split(',');
                      //
                      //       double latitude = double.parse(coordinates[0]);
                      //       double longitude = double.parse(coordinates[1]);
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => CustomMapWidget(latitude: latitude, longitude: longitude,title: "My Home Address",),
                      //         ),
                      //       );
                      //
                      //       //open in map
                      //     }, icon: Icon(
                      //       Icons.location_on_outlined,
                      //       color:Theme.of(context).primaryColor,
                      //       size: 30,
                      //     )),
                      //     GestureDetector( onTap: (){
                      //       List<String> coordinates = homeLocation.split(',');
                      //
                      //       double latitude = double.parse(coordinates[0]);
                      //       double longitude = double.parse(coordinates[1]);
                      //
                      //       openMap(latitude, longitude);
                      //     },child: Text("Share Address",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 14),)),
                      //
                      //     IconButton(onPressed: () async {
                      //
                      //       List<String> coordinates = homeLocation.split(',');
                      //
                      //       double latitude = double.parse(coordinates[0]);
                      //       double longitude = double.parse(coordinates[1]);
                      //
                      //       openMap(latitude, longitude);
                      //       // List<String> coordinates = homeLocation.split(',');
                      //       //
                      //       // double latitude = double.parse(coordinates[0]);
                      //       // double longitude = double.parse(coordinates[1]);
                      //       // final text = 'Latitude: $latitude\nLongitude: $longitude';
                      //       //
                      //       // await Share.share(
                      //       //   text,
                      //       //   subject: 'My Location',
                      //       //   sharePositionOrigin: Rect.fromLTWH(0, 0, 10, 10),
                      //       // );
                      //       //open in map
                      //     }, icon: Icon(
                      //       Icons.share_location_outlined,
                      //       color:Theme.of(context).primaryColor,
                      //       size: 30,
                      //     )),
                      //   ],
                      // ):const SizedBox(),
                      _listPob[index]['homeLocation']!=null?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ChangeAddressModal(id: _listPob[index]['id'],isHomeAddress:true);
                                },
                              );

                            },
                            label: const Text("Change Address"),
                            icon: const Icon(Icons.location_on_outlined, size: 20),
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
                              List<String> coordinates = homeLocation.split(',');

                              double latitude = double.parse(coordinates[0]);
                              double longitude = double.parse(coordinates[1]);

                              openMap(latitude, longitude);

                            },
                            label: const Text("Share Address"),
                            icon: const Icon(Icons.share, size: 20,),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.brown),
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
                      ):const SizedBox(),
                      _listPob[index]['homeLocation']==null?TextButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return MyFormModal1(id: _listPob[index]['id'],pob: _listPob[index]['pob']);
                            },
                          );
                        },
                        label: const Text("Add home Address"),
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
                      ):const SizedBox(),


                      _listPob[index]['homeLocation']!=null? const SizedBox(height: 10,):const SizedBox(),
                      _listPob[index]['officeLocation']!=null? Text("OFFICE ADDRESS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Theme.of(context).primaryColor),):const SizedBox(),

                      _listPob[index]['officeLocation']!=null? const SizedBox(height: 10,):const SizedBox(),
                      _listPob[index]['officeEmail']!=null ?Text("${_listPob[index]['officeEmail']}",style: const TextStyle(fontSize: 16,)):const SizedBox(),
                      _listPob[index]['officeLocation']!=null ? const SizedBox(height: 5,):const SizedBox(),
                      _listPob[index]['officeAddress']!=null ? Text(" ${_listPob[index]['officeAddress']}"):const SizedBox(),
                      _listPob[index]['officeLocation']!=null ?const SizedBox(height: 5,):const SizedBox(),
                      _listPob[index]['officePhone']!=null ? Text("${_listPob[index]['officePhone']}",style: const TextStyle(),):const SizedBox(),
                      _listPob[index]['officePhone']!=null?const SizedBox(height: 10,):const SizedBox(),

                      // _listPob[index]['officeLocation']!=null?
                      // Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     GestureDetector(onTap: (){
                      //       List<String> coordinates = officeLocation.split(',');
                      //
                      //       double latitude = double.parse(coordinates[0]);
                      //       double longitude = double.parse(coordinates[1]);
                      //
                      //
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => CustomMapWidget(latitude: latitude, longitude: longitude,title: "My Office Address",),
                      //         ),
                      //       );
                      //     },child: Text("View on map",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 14),)),
                      //     IconButton(onPressed: (){
                      //       //open in map
                      //       List<String> coordinates = officeLocation.split(',');
                      //
                      //       double latitude = double.parse(coordinates[0]);
                      //       double longitude = double.parse(coordinates[1]);
                      //
                      //
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => CustomMapWidget(latitude: latitude, longitude: longitude,title: "My Office Address",),
                      //         ),
                      //       );
                      //       },
                      //         icon: Icon(
                      //       Icons.location_on_outlined,
                      //       color:Theme.of(context).primaryColor,
                      //       size: 30,
                      //     )),
                      //     GestureDetector(onTap: (){
                      //       List<String> coordinates = officeLocation.split(',');
                      //
                      //       double latitude = double.parse(coordinates[0]);
                      //       double longitude = double.parse(coordinates[1]);
                      //
                      //       openMap(latitude, longitude);
                      //     },child: Text("Share Address",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 14),)),
                      //
                      //     IconButton(onPressed: (){
                      //       List<String> coordinates = officeLocation.split(',');
                      //
                      //       double latitude = double.parse(coordinates[0]);
                      //       double longitude = double.parse(coordinates[1]);
                      //
                      //       openMap(latitude, longitude);
                      //       //open in map
                      //     }, icon: Icon(
                      //       Icons.share_location_outlined,
                      //       color:Theme.of(context).primaryColor,
                      //       size: 30,
                      //     )),
                      //
                      //   ],
                      // ):const SizedBox(),
                      _listPob[index]['officeLocation']!=null?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ChangeAddressModal(id: _listPob[index]['id'],isHomeAddress:false);
                                },
                              );
                            },
                            label: const Text("Change Address"),
                            icon: const Icon(Icons.location_on_outlined, size: 20),
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
                              List<String> coordinates = officeLocation.split(',');

                              double latitude = double.parse(coordinates[0]);
                              double longitude = double.parse(coordinates[1]);

                              openMap(latitude, longitude);

                            },
                            label: const Text("Share Address"),
                            icon: const Icon(Icons.share, size: 20,),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.brown),
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
                      ):const SizedBox(),
                      const SizedBox(height: 5,),
                      _listPob[index]['officeLocation']==null?TextButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return MyFormModal1(id: _listPob[index]['id'],pob: _listPob[index]['pob']);
                            },
                          );
                        },
                        label: const Text("Add office Address"),
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
                      ):const SizedBox(),
                    ],
                  )
              ),
            );

          }
          else{
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 64),
                child:
                TextButton.icon(
                  onPressed: () {

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MyFormModal1(id: _listPob[index]['id'],pob: _listPob[index]['pob']);
                      },
                    );
                  },
                  label: const Text("Add Virtual Address"),
                  icon: const Icon(Icons.add, size: 20),
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
              ),
            );
          }

        }),
      ) : const Center(child: NoDataScreen()),
    );
  }
  var userId;
  @override
  void initState() {
    super.initState();
    _getUserInfo();


  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson=localStorage.getString("user");
    var user=json.decode(userJson);
    print("customer id");
    setState(() {
      userId=user['id'];
    });
    print(userId);
    loadPoxList();
  }

  loadPoxList() async {
    setState(() {
      _loading = true;
    });

    var res = await http.get(Uri.parse(AppConstants.baseUri + AppConstants.customerAddressUri+ '$userId'));

    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      print(jsonData);

      if (jsonData['data'] != null && jsonData['data'] is List) {
        List<dynamic> dataList = List<dynamic>.from(jsonData['data']);

        setState(() {
          _listPob = dataList;
        });
      }
    }

    setState(() {
      _loading = false;
    });
  }

  void openMap(double latitude, double longitude) async {
    String mapUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw 'Could not open the map.';
    }
  }


}




























































