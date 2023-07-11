import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/data/api/api_client.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';

class OrderRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  OrderRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> getCurrentOrders() async {
    return apiClient.getData(AppConstants.currentOrderUri);
  }

  Future<Response> getOrderDetails({String orderID}) async {
    return apiClient.getData('${AppConstants.orderDetailsUri}$orderID');
  }

  Future<Response> getAllOrderHistory(String type, String startDate, String endDate, String search, int isPause) async {
    Response response = await apiClient.getData('${AppConstants.allOrderHistoryUri}?status=$type&start_date=$startDate&end_date=$endDate&search=$search&is_pause=$isPause');
      return response;

  }

  Future<Response> updateOrderStatus({int orderId, String status}) async {
    Response response = await apiClient.postData(
        AppConstants.updateOrderStatusUri,
        {"order_id": orderId, "status": status, "_method": 'put'});
      return response;

  }

  Future<Response> rescheduleOrder({int orderId, String deliveryDate, String cause}) async {
    Response response = await apiClient.postData(
        AppConstants.rescheduleOrderStatusUri,
        {"order_id": orderId, "expected_delivery_date": deliveryDate, "_method": 'put', 'cause' : cause});
    return response;

  }

  Future<Response> pauseAndResumeOrder({int orderId, int isPos, String cause}) async {
    Response response = await apiClient.postData(
        AppConstants.pauseAndResumeOrderStatusUri,
        {"order_id": orderId, "is_pause": isPos, "_method": 'put', 'cause' : cause});
    return response;

  }

  Future<Response> cancelOrderStatus({int orderId, String cause}) async {
    Response response = await apiClient.postData(
        AppConstants.updateOrderStatusUri,
        {"order_id": orderId, "status": 'canceled', "_method": 'put', 'cause': cause});
    return response;

  }

  Future<Response> updatePaymentStatus({int orderId, String status}) async {
    Response response = await apiClient.postData(AppConstants.updatePaymentStatusUri,
        {"order_id": orderId, "payment_status": status, "_method": 'put'});
      return response;

  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }
}
