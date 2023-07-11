import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/helper/price_converter.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_button.dart';

import '../order_details_screen.dart';
import '../order_place_screen.dart';

class DeliveryDialog extends StatelessWidget {
  final Function onTap;
  final OrderModel orderModel;
  final int index;
  final double totalPrice;

  const DeliveryDialog({Key key, @required this.onTap, this.totalPrice, this.orderModel, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,
            vertical: Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            border: Border.all(color: Theme.of(context).primaryColor, width: 0.2)),


        child: Stack(clipBehavior: Clip.none, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 SizedBox(height: Dimensions.paddingSizeLarge),
                SizedBox(width: Dimensions.iconSizeExtraLarge, child: Image.asset(Images.moneyCollect)),
                 SizedBox(height: Dimensions.paddingSizeLarge),


                Center(
                    child: Text('do_you_collect_money'.tr,
                      style: rubikRegular.copyWith(
                          color: Theme.of(context).focusColor),)),
                 SizedBox(height: Dimensions.paddingSizeLarge),


                Center(
                    child: Text(PriceConverter.convertPrice(totalPrice),
                      style: Theme.of(context).textTheme.headline3.copyWith(
                          color: Theme.of(context).focusColor,fontSize: Dimensions.fontSizeHeadingLarge),)),
                 SizedBox(height: Dimensions.paddingSizeLarge),


                Row(children: [
                    Expanded(child: CustomButton(
                      btnTxt: 'no'.tr,
                      isShowBorder: true,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => OrderDetailsScreen(orderModel: orderModel)));
                      },
                    )),
                     SizedBox(width: Dimensions.paddingSizeDefault),


                    Expanded(
                        child: GetBuilder(
                          builder: (orderController) {
                            return !orderController.isLoading ? CustomButton(
                              btnTxt: 'yes'.tr,
                              onTap: () {
                                Get.find().updateTrackStart(false);
                                Get.find().updateOrderStatus(
                                orderId: orderModel.id,context: context,
                                status: 'delivered').then((value) {
                                  if (value) {
                                    orderController.updatePaymentStatus(orderId: orderModel.id, status: 'paid');
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (_) => OrderPlaceScreen(orderID: orderModel.id.toString(), orderModel: orderModel,)));
                                  }
                                });
                                },
                            ) :
                            Center(child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));
                            },
                        )),
                  ],
                ),
              ],
            ),


            Positioned(
              right: -20,
              top: -20,
              child: IconButton(padding: const EdgeInsets.all(0),
                  icon:  Icon(Icons.clear, size: Dimensions.paddingSizeLarge),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => OrderDetailsScreen(orderModel: orderModel)));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
