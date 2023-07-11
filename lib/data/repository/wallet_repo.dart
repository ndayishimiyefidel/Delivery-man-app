import 'package:flutter/material.dart';
import 'package:get/get_connect/connect.dart';
import 'package:sixvalley_delivery_boy/data/api/api_client.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';


class WalletRepo {
  final ApiClient apiClient;
  WalletRepo({@required this.apiClient});

  Future<Response> getDeliveryWiseEarned({String startDate, String endDate, int offset,String type}) async {
    return apiClient.getData('${AppConstants.deliveryWiseEarnedUri}?start_date=$startDate&end_date=$endDate&limit=10&offset=$offset&type=$type');
  }


  Future<Response> getWithdrawList({String startDate, String endDate, int offset, String type}) async {
    return apiClient.getData('${AppConstants.withdrawListUri}?limit=10&offset=$offset&start_date=$startDate&end_date=$endDate&type=$type');
  }

  Future<Response> sendWithdrawRequest({String amount, String note,}) async {
    return apiClient.postData(AppConstants.withdrawRequestUri,{
      "amount": amount,
      "note": note
    });
  }



  Future<Response> getDepositedList({String startDate, String endDate, int offset, String type}) async {
    return apiClient.getData('${AppConstants.depositedList}?limit=10&offset=$offset&start_date=$startDate&end_date=$endDate&type=$type');
  }


}
