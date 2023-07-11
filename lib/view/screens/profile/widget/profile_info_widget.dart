import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/localization_controller.dart';
import 'package:sixvalley_delivery_boy/controller/splash_controller.dart';
import 'package:sixvalley_delivery_boy/data/model/response/userinfo_model.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_image.dart';

class ProfileInfoWidget extends StatelessWidget {
  final bool isChat;
  final String name,phone;
  const ProfileInfoWidget({Key key, this.isChat = false, this.name, this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isChat? 100 : 120,
      width: MediaQuery.of(context).size.width,
      padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: Dimensions.profileImageSize, width: Dimensions.profileImageSize,
                decoration: BoxDecoration(shape: BoxShape.circle,
                    border: Border.all(color: Theme.of(context).cardColor, width: 3)),

                child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    // child: CustomImage(image: '${Get.find<SplashController>().baseUrls.reviewImageUrl}''/delivery-man/${profileModel.image}',width: 30,height: 30,),
                ),
              ),
              SizedBox(width: Get.find<LocalizationController>().isLtr? 0: Dimensions.paddingSizeSmall),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,style: const TextStyle(color: Colors.white,fontSize: 18),),
                      // Text(profileModel.fName != null ? '${profileModel.fName ?? ''} ${profileModel.lName ?? ''}' : "",maxLines: 1,overflow: TextOverflow.ellipsis,
                      //     style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                      //         color: Colors.white),
                      // ),
                       SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                      // Text(profileModel.phone != null ? profileModel.phone ?? '' : "",
                      //     style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                      //         color: Colors.white)),
                      Text(phone,style: const TextStyle(color: Colors.white,fontSize: 18),),
                    ],
                  ),
                ),
              ),
              const SizedBox(width:  Dimensions.logoHeight,),
            ],
          ),
            SizedBox(height:isChat? 0 : Dimensions.paddingSizeLarge),
        ],
      ),
    );
  }
}
