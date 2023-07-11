import 'dart:convert';

import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_tracking/widget/expendale_bottom_sheet.dart';

class OrderTrackingScreen extends StatefulWidget {
  final OrderModel orderModel;
  const OrderTrackingScreen({Key key, this.orderModel}) : super(key: key);

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  GoogleMapController  _controller;
  final TextEditingController _locationController = TextEditingController();
  CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    Get.find().initialPosition;

    Future.delayed(const Duration(seconds: 10)).then((value){
      Get.find().getCurrentLocation();
    });

  }

  @override
  Widget build(BuildContext context) {

    Get.find().setSelectedOrderLatLng(LatLng(double.parse(widget.orderModel.shippingAddress.latitude)??0,
        double.parse(widget.orderModel.shippingAddress.longitude)??0));
    return Scaffold(
      body: GetBuilder(
          builder: (riderController) {

            return ExpandableBottomSheet(

              background: Stack(
                clipBehavior: Clip.none,
                children: [

                  CustomGoogleMapMarkerBuilder(
                      customMarkers: riderController.customMarkers,
                      builder: (context, markers) {
                        return GoogleMap(
                          mapType: MapType.terrain,
                          initialCameraPosition:  CameraPosition(
                            target:  riderController.initialPosition,
                            zoom: 15,
                          ),
                          onMapCreated: (GoogleMapController controller){
                            riderController.mapController = controller;

                            LatLng destination = widget.orderModel.shippingAddress != null?
                            LatLng(double.parse(widget.orderModel.shippingAddress.latitude),
                                double.parse(widget.orderModel.shippingAddress.longitude))  : riderController.initialPosition;

                           riderController.getPolyline(from: riderController.initialPosition, to: destination);


                           riderController.setFromToMarker(from: riderController.initialPosition, to: destination) ;


                          },
                          minMaxZoomPreference: const MinMaxZoomPreference(0, 15),
                          markers: Set<Marker>.of(markers ?? []),
                          polylines: Set<Polyline>.of(riderController.polylines.values ?? []),
                          zoomControlsEnabled: false,
                          compassEnabled: false,
                          indoorViewEnabled: true,
                          mapToolbarEnabled: true,
                          onCameraIdle: () {

                          },
                          onCameraMove: ((_position) => _cameraPosition = _position),
                        );
                      }
                  ),

                  GestureDetector(
                    onTap: ()=> Get.back(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20,50,0,0),
                      child: Container(width: 40, height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).cardColor,
                        boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.125), blurRadius: 5, spreadRadius: 1, offset: const Offset(0,2))],
                      ),

                      child:  Icon(Icons.arrow_back_ios_new, color: Theme.of(context).hintColor,),),
                    ),
                  ),




                ],
              ),
              persistentHeader:  Container(
                padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeExtraSmall),
                margin:  EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault), color: Theme.of(context).primaryColor),
                child: Text('${riderController.distance != null? riderController.distance.toStringAsFixed(2) : 0} km', style: rubikRegular.copyWith(color: Theme.of(context).cardColor)),
              ),
              persistentContentHeight: riderController.persistentContentHeight,
              expandableContent: RiderBottomSheet(orderModel: widget.orderModel),

            );
          }
      ),
    );
  }
}
