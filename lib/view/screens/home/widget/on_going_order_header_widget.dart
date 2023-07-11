
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/localization_controller.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:sixvalley_delivery_boy/helper/date_converter.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/customer_info_widget.dart';

class OngoingOrderHeader extends StatelessWidget {
  final OrderModel orderModel;
  final int index;
  final bool isExpanded;
  const OngoingOrderHeader({Key key, this.orderModel, this.index, this.isExpanded = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Stack(
        children: [
          Positioned(
            child: Align(
              alignment: Get.find<LocalizationController>().isLtr? Alignment.topRight: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(width:Get.find<LocalizationController>().isLtr? Get.context.width<= 400? 160 : 165 :Get.context.width<= 400? 130 : 140,
                  child: Column(children: [
                    Row(children: [
                      Row(
                        children: [
                          Text('${'assigned'.tr} : ',style: rubikRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall),),
                          Text(DateConverter.isoStringToLocalDateOnly(orderModel.createdAt), style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                        ],
                      ),
                       SizedBox(width: Dimensions.paddingSizeSmall),
                      SizedBox(width: Dimensions.iconSizeDefault, child: Image.asset(Images.calenderIcon,
                          color:Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.25) : Theme.of(context).primaryColor.withOpacity(.5)))
                    ],),

                    orderModel.expectedDate != null?
                    Padding(
                      padding:  EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                      child: Row(
                        children: [
                          Text('${'expected_date'.tr} : ',
                            style: rubikRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall),),
                          Text(orderModel.expectedDate??'', style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                        ],
                      ),
                    ):const SizedBox(),


                  ]),
                ),
              ),
            ),
          ),
          Column(children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: Text('${'order'.tr} # ${orderModel.id}',
                style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),

            ],),
             SizedBox(height: Dimensions.paddingSizeDefault),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                SizedBox(width: Dimensions.iconSizeDefault,child: Image.asset(Images.sellerIcon)),
                 SizedBox(width: Dimensions.paddingSizeSmall),
                Text('seller'.tr,
                    style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge,
                        color: Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor))
              ],),

              Row(children: [
                Column(children: [
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall,bottom: Dimensions.paddingSizeExtraSmall),
                    child: Container(width: Dimensions.iconSizeSmall,height: Dimensions.iconSizeSmall,color: Theme.of(context).primaryColor),
                  ),Padding(
                    padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall,bottom: Dimensions.paddingSizeExtraSmall),
                    child: Container(width: Dimensions.iconSizeSmall,height: Dimensions.iconSizeSmall,color: Theme.of(context).primaryColor),
                  ),Padding(
                    padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeExtraSmall),
                    child: Container(width: Dimensions.iconSizeSmall,height: Dimensions.iconSizeSmall,color: Theme.of(context).primaryColor),
                  ),

                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall, top: 2),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).colorScheme.tertiary
                      ),
                      width: Dimensions.iconSizeSmall,
                      height: Dimensions.iconSizeSmall,
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall, top: 2),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).colorScheme.tertiary
                      ),
                      width: Dimensions.iconSizeSmall,
                      height: Dimensions.iconSizeSmall,
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall, top: 2),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).colorScheme.tertiary
                      ),
                      width: Dimensions.iconSizeSmall,
                      height: Dimensions.iconSizeSmall,
                    ),
                  ),


                ],),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                        SizedBox(width: Dimensions.paddingSizeDefault),
                      Text(orderModel.sellerIs == 'admin'? AppConstants.companyName: orderModel.sellerInfo?.shop?.name?.trim()??'Shop not found',
                          style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault))
                    ],),


                    Row(children: [
                       SizedBox(width:Get.context.width<=400? 15 : Dimensions.paddingSizeLarge),
                      Expanded(
                        child: Text(orderModel.sellerInfo?.shop?.address??'',
                            maxLines: 2,
                            style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).hintColor)),
                      )
                    ],),
                  ],),
                ),
              ],),




            ],),
             SizedBox(height: Dimensions.paddingSizeExtraSmall),

            CustomerInfoWidget(orderModel: orderModel),


            isExpanded?const SizedBox():
            Container(
                padding:  EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color:Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.25) : Theme.of(context).primaryColor.withOpacity(.04)),
                child: Icon(Icons.keyboard_arrow_down,
                  size: Dimensions.iconSizeLarge,color:Get.isDarkMode? Theme.of(context).hintColor: Theme.of(context).primaryColor.withOpacity(.75),)),

          ],),
        ],
      ),
    );
  }
}