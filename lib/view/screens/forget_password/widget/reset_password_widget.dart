import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_button.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_snackbar.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_text_field.dart';
import 'package:sixvalley_delivery_boy/view/screens/auth/login_screen.dart';

class ResetPasswordWidget extends StatefulWidget {
  final String mobileNumber;

  const ResetPasswordWidget({Key key,@required this.mobileNumber}) : super(key: key);

  @override
  _ResetPasswordWidgetState createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;
  final FocusNode _newPasswordNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();
  GlobalKey<FormState> _formKeyReset;

  @override
  void initState() {
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }


  void resetPassword() async {
      String _password = _passwordController.text.trim();
      String _confirmPassword = _confirmPasswordController.text.trim();

      if (_password.isEmpty) {
     showCustomSnackBar('password_is_required'.tr);
      } else if (_confirmPassword.isEmpty) {
       showCustomSnackBar('confirm_password_is_required'.tr);
      }
      else if (_password.length < 8) {
        showCustomSnackBar('password_at_least_8_character'.tr);
      }
      else if (_password != _confirmPassword) {
       showCustomSnackBar('password_not_match'.tr);
      } else {
        Get.find<ProfileController>().resetPassword(widget.mobileNumber,
            _password, _confirmPassword).then((value) {
          if(value.statusCode == 200) {
            Get.to(const LoginScreen());

          }
        });

      }
    // }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRiderAppBar(title: 'reset_password'.tr,isBack: true),
      body: Form(
        key: _formKeyReset,
        child: GetBuilder<ProfileController>(
          builder: (profileController) {
            return Padding(
              padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, 0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child: Text('new_password'.tr, style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                  ),
                  Container(
                      margin:
                       EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                      child: CustomTextField(
                        isShowBorder: true,
                        hintText: 'new_password'.tr,
                        focusNode: _newPasswordNode,
                        nextFocus: _confirmPasswordNode,
                        isPassword: true,
                        noBg: true,
                        prefixIconUrl: Images.lock,
                        isShowSuffixIcon: true,
                        controller: _passwordController,
                      )),


                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child: Text('confirm_password'.tr, style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                  ),
                  Container(
                      margin:  EdgeInsets.only(
                          bottom: Dimensions.paddingSizeLarge),
                      child: CustomTextField(
                        hintText: 'confirm_password'.tr,
                        isShowBorder: true,
                        inputAction: TextInputAction.done,
                        focusNode: _confirmPasswordNode,
                        isPassword: true,
                        prefixIconUrl: Images.lock,
                        noBg: true,
                        isShowSuffixIcon: true,
                        controller: _confirmPasswordController,
                      )),


                  profileController.isLoading ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: (Get.width/2)-40),
                      child: const SizedBox(width: 40,height: 40,
                          child: CircularProgressIndicator())) :
                  CustomButton(onTap: resetPassword, btnTxt: 'update_password'.tr),


                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
