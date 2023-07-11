import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/controller/splash_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_image.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_text_field.dart';

class GeneralInfo extends StatelessWidget {
  const GeneralInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {


        return ListView(
          physics: const BouncingScrollPhysics(),
          children: [

            Padding(
              padding:  EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text('first_name'.tr, style: rubikRegular),
                   SizedBox(height: Dimensions.paddingSizeSmall),
                  CustomTextField(
                    prefixIconUrl: Images.profileIcon,
                    isShowBorder: true,
                    noBg: true,
                    inputType: TextInputType.name,
                    focusNode: profileController.fNameFocus,
                    nextFocus: profileController.lNameFocus,
                    hintText: 'Firstname',
                    controller: profileController.firstNameController,
                  ),

                   SizedBox(height: Dimensions.paddingSizeDefault),
                  Text('last_name'.tr, style: rubikRegular),

                   SizedBox(height: Dimensions.paddingSizeSmall),
                  CustomTextField(
                    prefixIconUrl: Images.profileIcon,
                    noBg: true,
                    isShowBorder: true,
                    inputType: TextInputType.name,
                    focusNode: profileController.lNameFocus,
                    nextFocus: profileController.addressFocus,
                    hintText: 'Last Name',
                    controller: profileController.lastNameController,
                  ),
                   SizedBox(height: Dimensions.paddingSizeSmall),
                  Row(
                    children: [
                      Text('email'.tr, style: rubikRegular),
                    ],
                  ),
                   SizedBox(height: Dimensions.paddingSizeSmall),
                  CustomTextField(
                    prefixIconUrl: Images.emailIcon,
                    noBg: true,
                    fillColor: Theme.of(context).hintColor.withOpacity(.125),
                    isShowBorder: true,
                    isDisable: true,
                    inputType: TextInputType.name,
                    hintText: 'Email',
                    controller: profileController.emailController ,
                  ),
                   SizedBox(height: Dimensions.paddingSizeSmall),

                  Row(
                    children: [
                      Text('phone_no'.tr, style: rubikRegular),
                    ],
                  ),
                  SizedBox(height: Dimensions.paddingSizeSmall),
                  CustomTextField(
                    fillColor: Theme.of(context).hintColor.withOpacity(.125),
                    prefixIconUrl: Images.phoneIcon,
                    noBg: true,
                    isDisable: true,
                    isShowBorder: true,
                    inputType: TextInputType.number,
                    hintText: "Telephone",
                  ),
                   SizedBox(height: Dimensions.paddingSizeSmall),


                  Text('address_s'.tr, style: rubikRegular),
                   SizedBox(height: Dimensions.paddingSizeSmall),
                  CustomTextField(
                    prefixIconUrl: Images.addressIcon,
                    noBg: true,
                    isShowBorder: true,
                    inputType: TextInputType.name,
                    focusNode: profileController.addressFocus,
                    hintText: 'Address',
                    controller: profileController.addressController,
                  ),
                ],
              ),
            ),


          ],
        );
      }
    );
  }
}
