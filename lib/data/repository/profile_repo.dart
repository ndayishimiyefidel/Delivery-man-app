import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/data/api/api_client.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';

class ProfileRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ProfileRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> getProfileInfo() async {
    return await apiClient.getData(AppConstants.profileUri);
  }

  Future<Response> getReviewList(int offset, int isSaved) async {
    return await apiClient.getData('${AppConstants.reviewListUri}?is_saved=$isSaved&limit=20&offset=$offset');
  }

  Future<Response> profileStatusOnnOff( int status) async {
    Response _response = await apiClient.postData(AppConstants.statusOnOffUri,
        {
          'is_online': status,
          '_method': "put"
        });
    return _response;
  }

  Future<Response> saveReview( int reviewId, int isSaved) async {
    Response _response = await apiClient.postData(AppConstants.addToSavedReviewList,
        {
          'review_id': reviewId,
          '_method': "put",
          'is_saved': isSaved
        });
    return _response;
  }

  Future<Response> getEmergencyContactList() async {
    return await apiClient.getData(AppConstants.emergencyContactList);
  }


  Future<Response> forgetPassword(String countryCode ,String phone) async {
    Response _response = await apiClient.postData(AppConstants.forgetPassword,
        {
          'country_code' : countryCode,
          'phone': phone
        });
    return _response;
  }

  Future<Response> verifyOtp(String countryCode ,String phone) async {
    Response _response = await apiClient.postData(AppConstants.verifyOtp,
        {
          'otp' : countryCode,
          'phone': phone
        });
    return _response;
  }

  Future<Response> resetPassword(String phone, String password ,String confirmPassword) async {
    Response _response = await apiClient.postData(AppConstants.resetPassword,
        {
          'phone': phone,
          'password' : password,
          'confirm_password': confirmPassword
        });
    return _response;
  }

  Future<Response> updateBankInfo({String bankName, String branch, String accountNumber, String holderName}) async {
    return apiClient.postData(AppConstants.updateBankInfo,{
      "bank_name": bankName,
      "branch": branch,
      "account_no": accountNumber,
      "holder_name" : holderName,
      "_method": " put"
    });
  }

}
