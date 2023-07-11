import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/controller/theme_controller.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/order_item_info_widget.dart';


class CustomerWidget extends StatelessWidget {
  final OrderModel orderModel;
  final int index;
  const CustomerWidget({Key key, this.orderModel, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 100],
          blurRadius: 5, spreadRadius: 1)]),


      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        Row(children: [
          SizedBox(width: 20, child: Image.asset(Images.customerIcon)),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeDefault),
            child: Text('delivery_info'.tr,style: rubikMedium.copyWith(color: Theme.of(context).colorScheme.tertiary,
                fontSize: Dimensions.fontSizeLarge)),
          ),
        ],),


        Padding(
          padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, 0),
          child: Column(children: [
            OrderItemInfoWidget(title: 'name',info: '${orderModel.customer?.fName?? ''} ${orderModel.customer?.lName??''}'),
            OrderItemInfoWidget(title: 'contact',info: orderModel.customer?.phone??''),
            OrderItemInfoWidget(title: 'location', info: orderModel.shippingAddressData != null ?
            '${jsonDecode(orderModel.shippingAddressData)['address']}, '
                '${jsonDecode(orderModel.shippingAddressData)['city']}, '
                '${jsonDecode(orderModel.shippingAddressData)['zip']}' :  ''),
          ]),
        ),
         SizedBox(height: Dimensions.paddingSizeDefault),



      ]),
    );
  }
}
