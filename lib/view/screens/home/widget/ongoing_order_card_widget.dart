
import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/view/screens/home/widget/on_going_order_header_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/order_details_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_tracking/order_tracking_screen.dart';

class OnGoingOrderWidget extends StatelessWidget {
  final OrderModel orderModel;
  final int index;
  const OnGoingOrderWidget({Key key, this.orderModel, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.fromLTRB(0, 0, 0, Dimensions.paddingSizeSmall),
      child: Container(decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
        boxShadow: [BoxShadow(color: Get.isDarkMode ? Colors.grey[900] :Colors.grey[100], blurRadius: 5, spreadRadius: 1, offset: const Offset(0,2))],
      ),
        padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),

        child: ExpandableNotifier(
          child: Column(
            children: [
              Expandable(
                collapsed: ExpandableButton(
                  child: Column(
                    children: [
                      OngoingOrderHeader(orderModel: orderModel,index: index,),
                    ],
                  ),
                ),
                expanded: Column(
                    children: [
                      GestureDetector(
                          onTap: (){
                            // Get.to(OrderDetailsScreen(orderModel: orderModel));
                            // Get.find.selectedOrderLatLng(jsonDecode(orderModel.shippingAddressData)['latitude'],
                            //     jsonDecode(orderModel.shippingAddressData)['longitude']);
                            },
                          child: Container(
                            color: Theme.of(context).primaryColor.withOpacity(.0),
                              child: OngoingOrderHeader(orderModel: orderModel,index: index,isExpanded: true))),

                      GestureDetector(
                        onTap: () => Get.to(()=> OrderTrackingScreen(orderModel: orderModel)),
                        child: Container(height: Get.width/3,
                          padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                          child: Image.asset(Images.previewMap, fit: BoxFit.cover,)),
                      ),


                      // ReceiverWidget(orderModel: orderModel),

                      ExpandableButton(
                        child: Container(decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color:Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.123): Theme.of(context).primaryColor.withOpacity(.08)),
                            padding:  EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                            child:  Icon(Icons.keyboard_arrow_up,
                              size: Dimensions.iconSizeLarge,
                              color : Theme.of(context).primaryColor.withOpacity(.75),)),
                      ),
                    ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





