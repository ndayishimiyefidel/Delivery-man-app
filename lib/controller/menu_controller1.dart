
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/view/screens/home/home_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/notification/notification_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/order_history_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/physical_pob.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/virtual_pob.dart';
import 'package:sixvalley_delivery_boy/view/screens/profile/profile_screen.dart';

import '../view/screens/applications/pob_management.dart';
import '../view/screens/home/home_screen1.dart';
import '../view/screens/mails/mail_screen.dart';
import '../view/screens/mails/mail_screen1.dart';
import '../view/screens/notification/notification_screen1.dart';
import '../view/screens/order_history/order_history_screen1.dart';

class BottomMenuController1 extends GetxController implements GetxService{
  int _currentTab = 0;
  int get currentTab => _currentTab;
  List<Widget> screen;
  Widget _currentScreen;
  Widget get currentScreen => _currentScreen;
  BottomMenuController1() {
    initPage();
  }


  selectHomePage1({bool first = true}) {
    _currentScreen = screen[0];
    _currentTab = 0;
    if(first){
      update();
    }

  }

  void initPage() {
    screen = [
      HomeScreen1(onTap: (int index) {
        _currentTab = index;
        update();
      }),
      const PhysicalPob(),
      const PobManagement(),
      const VirtualPob(),
      const ProfileScreen(),
    ];
    _currentScreen = screen[0];
  }

  selectOrderHistoryScreen1({bool fromHome =  false}) {
    _currentScreen = const PhysicalPob();
    _currentTab = 1;
    update();

  }

  selectConversationScreen1() {
    _currentScreen = const PobManagement();
    _currentTab = 2;
    update();
  }

  selectNotificationScreen1() {
    _currentScreen = const VirtualPob();
    _currentTab = 3;
    update();
  }
  selectProfileScreen() {
    _currentScreen = const ProfileScreen();
    _currentTab = 4;
    update();
  }
}
