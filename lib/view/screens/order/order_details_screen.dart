import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/controller/theme_controller.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:sixvalley_delivery_boy/helper/price_converter.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_loader.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/customer_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/order_status_change_custom_button.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/order_status_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/payment_info_widget.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/seller_info_widget.dart';


class OrderDetailsScreen extends StatelessWidget {
  final OrderModel orderModel;
  const OrderDetailsScreen({Key key, this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find().getOrderDetails(orderModel.id.toString(), context);
    double deliveryCharge = 0;
    deliveryCharge = orderModel.shippingCost;
    return Scaffold(
      appBar: CustomRiderAppBar(title: 'order_information'.tr, isBack: true),

      body: GetBuilder(
        builder: (orderController) {
          double _itemsPrice = 0;
          double _discount = 0;
          double _tax = 0;
          if (orderController.orderDetails != null) {
            for (var orderDetails in orderController.orderDetails) {
              _itemsPrice = _itemsPrice + (orderDetails.price * orderDetails.qty);
              _discount = _discount + orderDetails.discount;
              _tax = _tax + orderDetails.tax;
            }
          }


          double _subTotal = _itemsPrice + _tax - _discount;
          double totalPrice = _subTotal  + deliveryCharge - orderModel.discountAmount;


          return orderController.orderDetails != null ?
          Column(children: [
            Expanded(child: ListView(
              physics: const BouncingScrollPhysics(),
              padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),
              children: [

                Padding(padding:  EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                  child: OrderStatusWidget(orderModel : orderModel)),

                // orderModel.orderStatus == 'processing' || orderModel.orderStatus == 'out_for_delivery'?
                // OrderInfoWithCustomerWidget(orderModel: orderModel): const SizedBox(),

                // orderModel.sellerInfo != null?
                // SellerInfoWidget(orderModel: orderModel): const SizedBox(),
                //  SizedBox(height: Dimensions.paddingSizeSmall,),

                // OrderInfoWidget(orderModel: orderModel, orderController: orderController,fromDetails: true),

                 // SizedBox(height: Dimensions.paddingSizeSmall),

                PaymentInfoWidget(itemsPrice: _itemsPrice,tax: _tax,subTotal: _subTotal,discount: _discount,deliveryCharge: deliveryCharge,totalPrice: totalPrice,),

                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                  child: Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    boxShadow: [BoxShadow(color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 100],
                      blurRadius: 5, spreadRadius: 1,)],
                    color: Theme.of(context).cardColor),
                    padding:  EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('additional_delivery_charge_by_admin'.tr, style: rubikMedium,),
                      DottedBorder(
                        color: Theme.of(context).primaryColor,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(45),
                        child: Container(
                          color: Theme.of(context).primaryColor.withOpacity(.05),
                          padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                          child: Row( children: [
                            Text(PriceConverter.convertPrice(orderModel.deliveryManCharge),style: rubikMedium),
                          ],),),),

                    ],),
                  ),
                ),

                Padding(padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: CustomerWidget(orderModel: orderModel, ),),

              ],
            ),
            ),

            OrderStatusChangeCustomButton(orderModel: orderModel,totalPrice: totalPrice)


          ],) : CustomLoader(height: Get.height);
        },
      ),
    );
  }
}

