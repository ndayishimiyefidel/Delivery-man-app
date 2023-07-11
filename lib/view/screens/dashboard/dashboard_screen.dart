
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/controller/menu_controller.dart';
import 'package:sixvalley_delivery_boy/helper/notification_helper.dart';
import 'package:sixvalley_delivery_boy/utill/color_resources.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/animated_custom_dialog.dart';
import 'package:sixvalley_delivery_boy/view/base/confirmation_dialog.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_botom_navy_bar.dart';



class DashboardScreen extends StatefulWidget {
  final int pageIndex;
   const DashboardScreen({Key key, @required this.pageIndex}) : super(key: key);
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final PageStorageBucket bucket = PageStorageBucket();
  SharedPreferences localStorage;
  bool isCustomerLogin=false;

  @override
  void initState() {
    super.initState();
    Get.find<BottomMenuController>().selectHomePage(first: false);
    var androidInitialize = const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationsSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("onMessage: ${message.data}");
      NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, false);



    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("onMessageOpenedApp: ${message.data}");


    });
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
    return WillPopScope(
      onWillPop: () async {
        _onWillPop(context);
        return true;
      },
      child: GetBuilder<BottomMenuController>(builder: (menuController) {
        return Scaffold(
          resizeToAvoidBottomInset: false,

          body: PageStorage(bucket: bucket, child: menuController.currentScreen),

          bottomNavigationBar: BottomNavyBar(
            selectedIndex: menuController.currentTab,
            showElevation: true,
            animationDuration: const Duration(milliseconds: 500),
            itemCornerRadius: 24,
            curve: Curves.ease,
            items: [
              _barItem(Images.homeIcon, 'Home'.tr, 0, menuController),
             _barItem(Images.orderIcon, 'Receive Mail'.tr, 1, menuController),
             _barItem(Images.location, 'Route'.tr, 2, menuController),
              _barItem(Images.addressIcon, 'Calibration'.tr, 3, menuController),
              _barItem(Images.profileIcon, 'Profile'.tr, 4, menuController),
            ],
            onItemSelected: (int index) {
              if(index == 0){
                menuController.selectHomePage();
              }else if(index == 1){
                menuController.selectOrderHistoryScreen();
              }else if(index == 2){
                menuController.selectConversationScreen();
              }else if(index == 3){
                menuController.selectNotificationScreen();
              }else if(index == 4){
                menuController.selectProfileScreen();
              }


            },
          ),

        );
      }),
    );
  }

  BottomNavyBarItem _barItem(String icon, String label, int index, BottomMenuController menuController) {
    return BottomNavyBarItem(
      activeColor: Theme.of(context).primaryColor,
      textAlign: TextAlign.center,
      icon: index == menuController.currentTab ?const SizedBox() :
      SizedBox(width: Dimensions.iconSizeMenu,
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Image.asset(icon, color : index == menuController.currentTab ?
          Theme.of(context).cardColor : ColorResources.colorGrey),
        )),
      title: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: Dimensions.iconSizeMedium,
              child: Image.asset(icon, color : index == menuController.currentTab ?
              Theme.of(context).cardColor : ColorResources.colorGrey)),
          const SizedBox(width: 4),
          Text(label, style: rubikRegular.copyWith(color: index == menuController.currentTab ?
          Colors.white : ColorResources.colorGrey)),
        ],
      ),
    );
  }


}
Future<bool> _onWillPop(BuildContext context) async {
  showAnimatedDialog(context,  ConfirmationDialog(icon: Images.logOut,
    title: 'exit_app'.tr,
    description: 'do_you_want_to_exit_the_app'.tr, onYesPressed: (){
    SystemNavigator.pop();
  },),isFlip: true);

  return true;
}


