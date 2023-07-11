import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_button.dart';
import 'package:sixvalley_delivery_boy/view/screens/dashboard/dashboard_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/review/review_screen.dart';

class OrderPlaceScreen extends StatelessWidget {
  final OrderModel orderModel;
  final String orderID;
  const OrderPlaceScreen({Key key, this.orderID, this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(padding:  EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              Image.asset(
              Images.orderCompletedImage),
               SizedBox(height: Dimensions.paddingSizeLarge),



              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('order_delivered'.tr,
                    style: rubikRegular.copyWith(
                        fontSize: Dimensions.fontSizeLarge),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                    child: Text('successfully'.tr,
                      style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
               SizedBox(height: Dimensions.paddingSizeOverLarge),


              InkWell(
                onTap: ()=> Get.to(ReviewScreen(orderModel: orderModel)),
                child: Container(width : 150, decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.05),
                  borderRadius: BorderRadius.circular(Dimensions.fontSizeExtraLarge),
                ),
                  padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeExtraSmall),
                  child: Center(
                    child: Text('see_review'.tr,
                      style: rubikRegular.copyWith(color: Theme.of(context).primaryColor,decoration: TextDecoration.underline),),
                  ),
                ),
              ),
               SizedBox(height: Dimensions.topSpace),


              const Spacer(),

              CustomButton(
                btnTxt: 'dashboard'.tr,
                onTap: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (_) => const DashboardScreen(pageIndex: 0,)), (route) => false),
              )
            ],
          ),
        ),
      ),
    );
  }
}
