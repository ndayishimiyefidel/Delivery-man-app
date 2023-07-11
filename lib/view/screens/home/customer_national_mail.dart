import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utill/app_constants.dart';
import '../../base/custom_home_app_bar.dart';
import '../../base/no_data_screen.dart';

class CustomerNationalMail extends StatefulWidget {
  const CustomerNationalMail({Key key}) : super(key: key);

  @override
  State<CustomerNationalMail> createState() => _CustomerNationalMailState();
}

class _CustomerNationalMailState extends State<CustomerNationalMail>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  final GlobalKey<ScaffoldState> _scaffoldkey =  GlobalKey<ScaffoldState>();
  bool _loading = false;
  List<dynamic> _customerMails = [];
  SharedPreferences localStorage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldkey,
      appBar: CustomRiderAppBar(title: 'EMS NATIONAL'.tr, isSwitch: true,isBack: true,),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _customerMails.isNotEmpty
          ? ListView.builder(
        itemCount: _customerMails.length,
        itemBuilder: ((context, index) {
          final branchesList = _customerMails[index];
          final branch = branchesList['branch'];
            return ScaleTransition(
              scale: _animation,
              child: Card(
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
                        Text("P.O. Box ${_customerMails[index]['pob']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Theme.of(context).primaryColor),),
                        const SizedBox(height: 5,),
                        Text("Dispatch Number: ${_customerMails[index]['dispatchNumber']}",style: const TextStyle(fontSize: 16),),
                        const SizedBox(height: 5,),
                        Text("Ref Number: "+_customerMails[index]['refNumber'],style: const TextStyle(fontSize: 16),),
                        const SizedBox(height: 5,),
                        Text("Destination ID: ${_customerMails[index]['destination_id']}",style: const TextStyle(fontSize: 16),),
                        const SizedBox(height: 5,),
                        Text("Price & Weight: ${_customerMails[index]['price']} Rwf ${_customerMails[index]['weight']} kg",style: const TextStyle(fontSize: 16),),
                        const SizedBox(height: 5,),
                        Text("Pick Up Date: ${_customerMails[index]['pickUpDate']==null ? "Not set": '${_customerMails[index]['pickUpDate']}'}",style: const TextStyle(fontSize: 16),),
                        const SizedBox(height: 5,),
                        Text("Delivered Date: ${_customerMails[index]['deliveredDate']==null ? "No delivered Date set":'${_customerMails[index]['deliveredDate']}'}",style: const TextStyle(fontSize: 16),),
                        const SizedBox(height: 5,),
                        Text("status: ${_customerMails[index]['status']==5?"Delivered":"Processing."}",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 16,),),
                        const SizedBox(height: 5,),

                        // AnimatedButton(),
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
    loadPoxList();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();

  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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

    var res = await http.get(Uri.parse(AppConstants.baseUri+AppConstants.customerNationalUri+'$loggedInUserId'));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      print(jsonData);
      if (jsonData['data'].isNotEmpty) {
        setState(() {
          _customerMails = jsonData['data'];
        });
      }
    }
    setState(() {
      _loading = false;
    });
  }
}
class AnimatedButton extends StatefulWidget {
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isPressed = false;

  void _handleTap() {
    setState(() {
      _isPressed = !_isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: _isPressed ? Colors.blue : Colors.green,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Request Home Delivery',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}



























































