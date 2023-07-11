import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/localization_controller.dart';
import 'package:sixvalley_delivery_boy/controller/splash_controller.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_image.dart';

class SellerInfoWidget extends StatelessWidget {
  final OrderModel orderModel;

  const SellerInfoWidget({Key key, this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.05),
              blurRadius: 5, spreadRadius: 1)],
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: Column(
        children: [
          orderModel.sellerInfo != null?
          Row(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(.25),
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(50),
              ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CustomImage(
                    image: '${Get.find<SplashController>().baseUrls.shopImageUrl}/${orderModel.sellerInfo.shop?.image}',
                    height: 50, width: 50, fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: Get.find<LocalizationController>().isLtr? 0 : Dimensions.paddingSizeSmall),

              Expanded(
                child: Padding(
                  padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,0,0,0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(orderModel.sellerIs == 'admin' ? AppConstants.companyName : orderModel.sellerInfo.shop.name,
                        style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),

                      Text(orderModel.sellerIs == 'admin' ? 'admin'.tr :'seller'.tr,
                          style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                              color: Theme.of(context).primaryColor.withOpacity(.75))),
                    ],
                  ),
                ),
              ),

              // CallAndChatWidget(orderModel: orderModel, isSeller: true, isAdmin: orderModel.sellerIs == 'admin',),
            ],
          ):const SizedBox(),

        ],
      ),
    );
  }
}
