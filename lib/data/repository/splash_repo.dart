import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/data/api/api_client.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';

class SplashRepo {
  ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SplashRepo({@required this.sharedPreferences, @required this.apiClient});

  // Future<Response> getConfigData() async {
  //   Response _response = await apiClient.getData(AppConstants.configUri);
  //   return _response;
  // }

  Future<bool> initSharedData() {
    if(!sharedPreferences.containsKey(AppConstants.theme)) {
      return sharedPreferences.setBool(AppConstants.theme, false);
    }
    if(!sharedPreferences.containsKey(AppConstants.countryCode)) {
      return sharedPreferences.setString(AppConstants.countryCode, AppConstants.languages[0].countryCode);
    }
    if(!sharedPreferences.containsKey(AppConstants.languageCode)) {
      return sharedPreferences.setString(AppConstants.languageCode, AppConstants.languages[0].languageCode);
    }
    if(!sharedPreferences.containsKey(AppConstants.intro)) {
      sharedPreferences.setBool(AppConstants.intro, true);
    }

    return Future.value(true);
  }



  String getCurrency() {
    return sharedPreferences.getString(AppConstants.currency) ?? '';
  }

  void setCurrency(String currencyCode) {
    sharedPreferences.setString(AppConstants.currency, currencyCode);
  }

  Future<bool> removeSharedData() {
    return sharedPreferences.remove(AppConstants.token);
  }
  void disableIntro() {
    sharedPreferences.setBool(AppConstants.intro, false);
  }

  bool showIntro() {
    if(AppConstants.intro != null){
      if(!sharedPreferences.containsKey(AppConstants.intro)) {
        sharedPreferences.setBool(AppConstants.intro, true);
      }
      return sharedPreferences.getBool(AppConstants.intro?? true);
    }
    return false;

  }

  void disableNotification() {
    sharedPreferences.setBool(AppConstants.notificationSound, false);
  }
  void enableNotification() {
    sharedPreferences.setBool(AppConstants.notificationSound, true);
  }

  bool notificationSound() {
    if(AppConstants.notificationSound != null){
      if(!sharedPreferences.containsKey(AppConstants.notificationSound)) {
        sharedPreferences.setBool(AppConstants.notificationSound, true);
      }
      return sharedPreferences.getBool(AppConstants.notificationSound?? true);
    }
    return false;

  }

}