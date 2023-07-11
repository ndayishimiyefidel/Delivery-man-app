import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/controller/splash_controller.dart';
import 'package:sixvalley_delivery_boy/helper/price_converter.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_image.dart';

import '../../../../utill/images.dart';
class EarnStatementWidget extends StatelessWidget {
  final String profile;
  final String mails;
  final String phone,email;
  final String carName,carPlate;

  const EarnStatementWidget({Key key, this.profile, this.mails, this.phone, this.email, this.carName, this.carPlate}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children:[

        // GetBuilder<ProfileController>(
        //   builder: (profileController) {
            Container(height: 180,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius:  BorderRadius.only(bottomLeft:Radius.circular(Dimensions.paddingSizeDefault),
                      bottomRight:Radius.circular(Dimensions.paddingSizeDefault))),

              child: Stack(children: [Positioned.fill(
                  child: Align(alignment: Alignment.topLeft,
                    child: Container(width: 250, height : 200, decoration: BoxDecoration(
                        color: Theme.of(context).cardColor.withOpacity(.05),
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(500))))),),


                Padding(padding:  EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                        child: Padding(
                          padding:  EdgeInsets.only(top: Dimensions.paddingSizeExtraLarge),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                          Container(decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight.withOpacity(.25),
                            border: Border.all(color: Theme.of(context).primaryColorLight),
                            borderRadius: BorderRadius.circular(50)),

                            child: ClipRRect(borderRadius: BorderRadius.circular(50),
                              child: const CustomImage(image: Images.profileImage,
                                height: 40, width: 40, fit: BoxFit.cover))),


                          Expanded(
                            child: Padding(padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,0,0,0),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(''),
                                  // Get.find<ProfileController>().profileModel !=null?
                                  //${Get.find<ProfileController>().profileModel.fName??''} ${Get.find<ProfileController>().profileModel.lName}
                                  Text(profile.tr,
                                    overflow: TextOverflow.ellipsis, maxLines: 1,
                                    style: rubikRegular.copyWith(color: Colors.white,fontSize: Dimensions.fontSizeDefault),),
                                  const SizedBox(height: 4,),
                                  Text(email.tr,
                                    overflow: TextOverflow.ellipsis, maxLines: 1,
                                    style: rubikRegular.copyWith(color: Colors.white,fontSize: Dimensions.fontSizeDefault),),

                                  const SizedBox(height: 10,),
                                  Text('Car Name: '+carName.tr,
                                    overflow: TextOverflow.ellipsis, maxLines: 1,
                                    style: rubikRegular.copyWith(color: Colors.white,fontSize: Dimensions.fontSizeDefault),),
                                  const SizedBox(height: 4,),
                                  Text('Car Plate:'+carPlate.tr,
                                    overflow: TextOverflow.ellipsis, maxLines: 1,
                                    style: rubikRegular.copyWith(color: Colors.white,fontSize: Dimensions.fontSizeDefault),),
                                ],
                              )),
                          ),

                          Column(crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(''),
                              Padding(padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,0,0,Dimensions.paddingSizeSmall),
                                  child: Text(mails,
                                  // child: Text(' ${PriceConverter.convertPrice(Get.find<ProfileController>().profileModel.currentBalance)}',
                                    style: rubikMedium.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeExtraLarge,),)),
                              Padding(padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,0,0,Dimensions.paddingSizeDefault),
                                  child: Text('All mails'.tr,
                                    style: rubikRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge),)),
                            ],
                          ),
                    ]),
                        ),
                      ),
                       SizedBox(height: Dimensions.paddingSizeDefault),

                    ],
                  ),
                ),
              ],
            ),),
        //   }
        // ),
      ]
    );
  }
}

