
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_stepper.dart';

class TrackingStepperWidget extends StatelessWidget {
  final String status;

  const TrackingStepperWidget({Key key, @required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _status = -1;

    if(status == 'confirmed') {
      _status = 0;
    }else if(status == 'processing') {
      _status = 1;
    }else if(status == 'out_for_delivery') {
      _status = 2;
    }else if(status == 'delivered') {
      _status = 3;
    }

    return Container(
      padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
        color: Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.15) :Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
      ),
      child: Row(children: [
        CustomStepper(
          title: 'order_confirmed'.tr, isActive: _status > -1, haveLeftBar: false, haveRightBar: true, rightActive: _status > 0,
          icon: Images.orderConfirmationIcon,
        ),
        CustomStepper(
          title: 'order_processing'.tr, isActive: _status > 0, haveLeftBar: true, haveRightBar: true, rightActive: _status > 1,
          icon: Images.orderProcessingIcon,
        ),
        CustomStepper(
          title: 'out_for_delivery'.tr, isActive: _status > 1, haveLeftBar: true, haveRightBar: true, rightActive: _status > 2,
          icon: Images.orderOutForDeliveryIcon,
        ),
        CustomStepper(
          title: 'delivered'.tr, isActive: _status > 2, haveLeftBar: true, haveRightBar: false, rightActive: _status > 3,
          icon: Images.orderDeliveredIcon,
        ),
      ]),
    );
  }
}
