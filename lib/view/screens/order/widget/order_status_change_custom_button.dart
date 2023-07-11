import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/order_place_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/delivery_dialog.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/slider_button.dart';
import 'package:get/get.dart';

class OrderStatusChangeCustomButton extends StatelessWidget {
  final OrderModel orderModel;
  final int index;
  final double totalPrice;
  const OrderStatusChangeCustomButton({Key key, this.orderModel, this.index, this.totalPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (orderModel.orderStatus == 'processing' || orderModel.orderStatus == 'out_for_delivery') && orderModel.isPause == '0' ?
    Padding(
      padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeSmall),
      child: SliderButton(
        action:  ()  {
          if(orderModel.orderStatus == 'processing'){
            Get.find().updateOrderStatus(orderId: orderModel.id,
                status: 'out_for_delivery',context: context);
            Get.find().getCurrentOrders(context);
          }else if(orderModel.orderStatus == 'out_for_delivery'){
            if (orderModel.paymentStatus == 'paid') {
              Get.find().updateOrderStatus(orderId: orderModel.id,
                  status: 'delivered',context: context);
              Get.find().updateTrackStart(false);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => OrderPlaceScreen(orderID: orderModel.id.toString(), orderModel: orderModel,)));
            } else {
              showDialog(context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      child: DeliveryDialog(
                        onTap: () {},
                        index: index,
                        totalPrice: totalPrice,
                        orderModel: orderModel,
                      ),
                    );
                  });
            }
          }

        },

        label: Text(orderModel.orderStatus == 'processing'? 'swipe_to_out_for_delivery_order'.tr : 'swip_to_deliver_order'.tr,
          style: rubikMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),),
        dismissThresholds: 0.5,
        icon: const RotationTransition(
          turns:  AlwaysStoppedAnimation(45 / 360),
          child: Center(child: Icon(CupertinoIcons.paperplane,
            color: Colors.white, size: 20.0,
            semanticLabel: 'Text to announce in accessibility modes',)),
        ),

        radius: 100,
        width: MediaQuery.of(context).size.width,
        boxShadow: const BoxShadow(blurRadius: 0.0),
        buttonColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(.05),
        baseColor: Theme.of(context).primaryColor,
      ),
    ):const SizedBox();}
}
