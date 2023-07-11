
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_tracking/order_tracking_screen.dart';


class OngoingMap extends StatelessWidget {
  final OrderModel orderModel;
  const OngoingMap({Key key, this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoogleMapController  _controller;
    TextEditingController _locationController = TextEditingController();
    CameraPosition _cameraPosition;
    return GetBuilder(
        builder: (riderController) {
          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(
              children: [
                Container(height: 200,width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault)
                    ),

                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CustomGoogleMapMarkerBuilder(
                            customMarkers: riderController.customMarkers,
                            builder: (context, markers) {
                              return GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition:  CameraPosition(
                                  target:  riderController.initialPosition,
                                  zoom: 15,
                                ),
                                onMapCreated: (GoogleMapController controller){
                                  riderController.mapController = controller;
                                 // riderController.setMarkers(riderController.latLngList);

                                },
                                minMaxZoomPreference: const MinMaxZoomPreference(0, 15),
                                markers: Set<Marker>.of(markers ?? []),
                                polylines: Set<Polyline>.of(riderController.polylines.values ?? []),
                                zoomControlsEnabled: false,
                                compassEnabled: false,
                                indoorViewEnabled: true,
                                mapToolbarEnabled: true,
                                onCameraIdle: () {
                                  //locationProvider.updatePosition(_cameraPosition, false, null, context);
                                },
                                onCameraMove: ((_position) => _cameraPosition = _position),
                              );
                            }
                        ),

                        Positioned(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () => Get.to(()=> OrderTrackingScreen(orderModel: orderModel)),
                              child: Padding(
                                padding:  EdgeInsets.all(Dimensions.paddingSizeDefault),
                                child: Container(padding:  EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault,
                                    vertical: Dimensions.paddingSizeExtraSmall),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor.withOpacity(.5),
                                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                                      border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5))
                                  ),
                                  child: Text('view_on_map'.tr),),
                              ),
                            ),
                          ),
                        )




                      ],
                    )),
              ],
            ),
          );
        }
    );
  }
}