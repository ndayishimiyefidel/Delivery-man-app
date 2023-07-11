import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:get/get.dart';

class OrderStatusWidget extends StatelessWidget {
  final OrderModel orderModel;
  const OrderStatusWidget({Key key, this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
      color: Theme.of(context).primaryColor.withOpacity(.05),
      border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.25),width: .5)),
      padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,
        vertical: Dimensions.paddingSizeSmall),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
        Text('${'order_status'.tr} : ',style: rubikRegular.copyWith(color: Get.isDarkMode? Theme.of(context).hintColor : Theme.of(context).primaryColor.withOpacity(.75))),
        Text(orderModel.orderStatus.tr,style: rubikMedium.copyWith(color: Get.isDarkMode? Theme.of(context).hintColor : Theme.of(context).primaryColor),)
      ],),
    );
  }
}
