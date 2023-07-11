import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/localization_controller.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_button.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_snackbar.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_text_field.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRiderAppBar(title: 'forget_password'.tr, isBack: true,),

      body: GetBuilder<ProfileController>(
        builder: (profileController) {
          return Padding(
            padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,0, Dimensions.paddingSizeDefault,0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Padding(
                    padding:  EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                    child: Text('forget_password'.tr, style: rubikMedium),
                  ),

                  Text('Enter email for password reset'.tr,
                      style: rubikRegular.copyWith(color: Theme.of(context).hintColor,
                          fontSize: Dimensions.fontSizeDefault)),



               SizedBox(height: Dimensions.paddingSizeDefault),

                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
                        borderRadius: BorderRadius.circular(Dimensions.topSpace)
                    ),
                    child: Stack(
                      children: [

                        Container(width:61, height: 53,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(.125),
                                borderRadius: Get.find<LocalizationController>().isLtr? BorderRadius.only(
                                    topLeft: Radius.circular(Dimensions.topSpace),
                                    bottomLeft: Radius.circular(Dimensions.topSpace)):
                                BorderRadius.only(
                                    topRight: Radius.circular(Dimensions.topSpace),
                                    bottomRight: Radius.circular(Dimensions.topSpace))
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top : 4.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom : 4.0),
                                child: SizedBox(width: 59,height: 20, child: Icon(Icons.email,color: Colors.blueAccent,size: 20,)),
                              ),
                              Expanded(
                                child: CustomTextField(
                                  hintText: 'example@gmail.com',
                                  noPadding: true,
                                  nextFocus: _emailFocus,
                                  controller: _emailController,
                                  focusNode: _emailFocus,
                                  inputType: TextInputType.text,
                                  inputAction: TextInputAction.next,
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),


                   SizedBox(height: Dimensions.paddingSizeLarge),



                  !profileController.isForget?
                  CustomButton(
                    btnTxt: 'send_otp'.tr,
                    onTap: () {
                        if(_emailController.text.isEmpty) {
                         showCustomSnackBar('Email is required'.tr);

                        }else{


                        }
                    },
                  ) :
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: (Get.width/2)-40),
                      child: const SizedBox(width: 40,height: 40,
                        child: CircularProgressIndicator()),
                    ),

            ]),
          );
        }
      ),
    );
  }
}

