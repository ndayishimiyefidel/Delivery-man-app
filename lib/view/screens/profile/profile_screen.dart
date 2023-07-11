import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/data/model/response/userinfo_model.dart';
import 'package:sixvalley_delivery_boy/mobileapi/api.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/animated_custom_dialog.dart';
import 'package:sixvalley_delivery_boy/view/base/confirmation_dialog.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/base/online_offline_button.dart';
import 'package:sixvalley_delivery_boy/view/screens/auth/login_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/emergency_contact/emergency_contact_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/help_and_support/help_and_support_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/html/html_viewer_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/profile/widget/profile_button.dart';
import 'package:sixvalley_delivery_boy/view/screens/profile/widget/profile_delivery_info_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/profile/widget/profile_header_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/review/review_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/setting/setting_screen.dart';

import 'edit_profile_screen.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {

    UserInfoModel profile = Get.find<ProfileController>().profileModel;
    return Scaffold(
        appBar: CustomRiderAppBar(title: 'my_profile'.tr),

        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: GetBuilder<ProfileController>(builder: (profileController){

              return Column(
                children: [

                  ProfileHeaderWidget(name: '$_userName',phone: isCustomerLogin==true ? '$_userEmail':'$_userPhone',),
                  Container(
                    padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: Column(children: [

                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeDefault),
                        child: Row(children: [
                          SizedBox(width: 20, child: Image.asset(Images.statusIcon, color: Theme.of(context).colorScheme.primary,)),
                          SizedBox(width: Dimensions.paddingSizeDefault),
                          Expanded(child: Text('status'.tr,style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
                          const OnlineOfflineButton(showProfileImage: false)

                        ],),
                      ),

                      ProfileButton(icon: Images.userIcon, title: 'My Profile'.tr,
                          onTap: () => Get.to(()=> const ProfileEditScreen())),


                      ProfileButton(icon: Images.emergencyContact, title: 'emergency_contact'.tr,
                          onTap: () {

                           // Get.to(const EmergencyContactScreen()
                          }),



                      // ProfileButton(icon: Images.helpSupport, title: 'help_and_support'.tr,
                      //     onTap: () => Get.to(const HelpAndSupport())),





                      ProfileButton(icon: Images.settingIcon, title: 'setting'.tr,
                          onTap: () => Get.to(const SettingScreen())),


                      // ProfileButton(icon: Images.myReview, title: 'privacy_policy'.tr,
                      //     onTap: () => Get.to(const HtmlViewerScreen(isPrivacyPolicy: true))),


                      ProfileButton(icon: Images.myReview, title: 'terms_and_condition'.tr,
                          onTap: () => Get.to(const HtmlViewerScreen(isPrivacyPolicy: false))),



                      ProfileButton(icon: Images.logOut, title: 'log_out'.tr,
                          onTap: () => showAnimatedDialog(context,  ConfirmationDialog(icon: Images.logOut,
                            title: 'log_out'.tr,
                            description: 'do_you_want_to_log_out_this_account'.tr, onYesPressed: (){
                              // Get.find<AuthController>().clearSharedData().then((condition) {
                              //   Get.back();
                              //   Get.offAll(const LoginScreen());
                              // });
                              _logout();

                            },),isFlip: true)),

                    ],
                    ),
                  )
                ],
              );

            },)
        ));
  }

  Future<void> _logout() async {
    var res= await CallApi().driverLogout(AppConstants.driverLogoutUri);
    var data = json.decode(res.body);
    if(data['success']==true){
      // Clear the user's session
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      localStorage.remove('user');
      localStorage.remove('isCompleted');
      localStorage.clear();
      // Redirect to the login screen
      Get.offAll(const LoginScreen());
    }
  }

  @override
  void initState() {
    _getUserInfo();
    // _loadData(context);
    super.initState();
  }
  bool isCustomerLogin=false;
  int rowCount=0;
  int numberDelivery=0;
  int numberPending=0;
  var userId;
  var _userEmail;
  var userData;
  var _userName;
  var _userPhone;

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson=localStorage.getString("user");
    isCustomerLogin=localStorage.getBool("isCustomerLogin");
    print(isCustomerLogin);
    var user=json.decode(userJson);
    // print(user['id']);
    setState(() {
      userId=user['id'];
      _userName=user['name'];
      _userEmail=user['email'];
      _userPhone=user['phone'];
    });

    totalMails();
    getPending();
    getDelivery();
  }
  Future<void> totalMails() async {
    final response = await http.get(Uri.parse(AppConstants.baseUri+AppConstants.getTotalMailUri+'$userId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        rowCount = data['count'];
        print(rowCount);
      });
    } else {
      // Handle error
    }
  }
  Future<void> getDelivery() async {
    final response = await http.get(Uri.parse(AppConstants.baseUri+AppConstants.getDeliveredMailUri+'$userId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        numberDelivery = data['count'];
        print(rowCount);
      });
    } else {
      // Handle error
    }
  }
  Future<void> getPending() async {
    final response = await http.get(Uri.parse(AppConstants.baseUri+AppConstants.getPendingMailUri+'$userId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        numberPending = data['count'];
        print(rowCount);
      });
    } else {
      // Handle error
    }
  }


}

