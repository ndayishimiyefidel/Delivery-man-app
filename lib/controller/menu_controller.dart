
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/view/screens/home/home_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/notification/notification_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/order_history_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/profile/profile_screen.dart';

import '../view/screens/mails/mail_screen.dart';

class BottomMenuController extends GetxController implements GetxService{
  int _currentTab = 0;
  int get currentTab => _currentTab;
  List<Widget> screen;
  Widget _currentScreen;
  Widget get currentScreen => _currentScreen;
  BottomMenuController() {
    initPage();
  }


  selectHomePage({bool first = true}) {
    _currentScreen = screen[0];
    _currentTab = 0;
    if(first){
      update();
    }

  }

  void initPage() {
    screen = [
      HomeScreen(onTap: (int index) {
        _currentTab = index;
        update();
      }),
      const OrderHistoryScreen(fromMenu: true,),
      const ConversationScreen(),
      const NotificationScreen(),
      const ProfileScreen(),
    ];
    _currentScreen = screen[0];
  }

  selectOrderHistoryScreen({bool fromHome =  false}) {
    _currentScreen = const OrderHistoryScreen();
    _currentTab = 1;
    update();

  }

  selectConversationScreen() {
    _currentScreen = const ConversationScreen();
    _currentTab = 2;
    update();
  }

  selectNotificationScreen() {
    _currentScreen = const NotificationScreen();
    _currentTab = 3;
    update();
  }
  selectProfileScreen() {
    _currentScreen = const ProfileScreen();
    _currentTab = 4;
    update();
  }
}
