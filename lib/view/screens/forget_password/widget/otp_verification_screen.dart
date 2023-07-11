import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/utill/color_resources.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_button.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_snackbar.dart';
import 'package:sixvalley_delivery_boy/view/screens/forget_password/widget/reset_password_widget.dart';


class VerificationScreen extends StatelessWidget {
  final String mobileNumber;
  final String countryCode;

  const VerificationScreen({Key key, this.countryCode, this.mobileNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRiderAppBar(title: 'verification'.tr,isBack: true,),
      body: GetBuilder<ProfileController>(
        builder: (profileController) {
          return Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [



              Padding(
                padding:  EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                child: Text('please_enter_4_digit_code'.tr,style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                  textAlign: TextAlign.center,),
              ),


              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width/7, vertical: Dimensions.paddingSizeDefault),
                child: PinCodeTextField(
                  length: 4,
                  appContext: context,
                  obscureText: false,
                  showCursor: true,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.circle,
                    fieldHeight: 50,
                    fieldWidth: 50,
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraLarge),
                    selectedColor: ColorResources.colorMap[200],
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.125): Theme.of(context).primaryColor.withOpacity(.1),
                    inactiveColor: ColorResources.colorMap[200],
                    activeColor:Get.isDarkMode? Theme.of(context).hintColor: ColorResources.colorMap[400],
                    activeFillColor: Theme.of(context).primaryColor.withOpacity(.025),
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onChanged: profileController.updateVerificationCode,
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
              ),


              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('${'if_you_did_not_receive_a_code'.tr},'),
                InkWell(
                  onTap: () {
                    profileController.forgetPassword(countryCode ,mobileNumber).then((value) {
                      if (value.statusCode == 200) {
                        showCustomSnackBar('otp_send_successfully'.tr, isError: false);
                      }
                    });
                  },
                  child: Padding(
                    padding:  EdgeInsets.only(left : Dimensions.paddingSizeSmall),
                    child: Text('resend'.tr,
                      style: rubikMedium.copyWith(color:Get.isDarkMode? Theme.of(context).hintColor: Theme.of(context).primaryColor.withOpacity(.75)),)),
                ),
              ]),

              Padding(
                  padding:  EdgeInsets.only(top : Dimensions.paddingSizeSmall),
                  child: Text('otp_will_expired_after_2_minute'.tr,
                    style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).hintColor.withOpacity(.75)),)),


              const SizedBox(height: 50),


              profileController.isEnableVerificationCode ? !profileController.isPhoneNumberVerificationButtonLoading ?
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                child: CustomButton(
                  btnTxt:  'verify'.tr,
                  onTap: () {
                    profileController.verifyOtp( profileController.verificationCode, mobileNumber).then((value) {
                      if(value.statusCode == 200) {
                        Get.to(ResetPasswordWidget(mobileNumber: mobileNumber));
                      }else {
                        showCustomSnackBar('input_valid_otp'.tr);
                      }
                    });
                    }),):
              Padding(
                padding: EdgeInsets.symmetric(horizontal: (Get.width/2)-40),
                child: const SizedBox(width: 40,height: 40,
                    child: CircularProgressIndicator())) :
              const SizedBox.shrink()

            ],
          );
        }
      ),
    );
  }
}
