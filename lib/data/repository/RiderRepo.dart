import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sixvalley_delivery_boy/data/api/api_client.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';

class RiderRepo {
  final ApiClient apiClient;

  RiderRepo({@required this.apiClient});

  Future<Response> getDistanceInMeter(LatLng from, LatLng to) async {
    return await apiClient.postData(AppConstants.distanceApi, {
      'origin_lat': from.latitude,
      'origin_lng': from.latitude,
      'destination_lat': to.latitude,
      'destination_lng': to.latitude
    });
  }

}
