import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/controller/localization_controller.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';
import 'package:sixvalley_delivery_boy/utill/color_resources.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_button.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_snackbar.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_text_field.dart';
import 'package:sixvalley_delivery_boy/view/screens/auth/register_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/dashboard/dashboard_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/dashboard/dashboard_screen1.dart';

import '../../../mobileapi/api.dart';
import '../forget_password/forget_password_screen.dart';



class LoginScreen extends StatefulWidget {
   const LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  GlobalKey<FormState> _formKeyLogin;
  String _countryDialCode = "+250";
  bool _isLoading=false;

  TabController _tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

  }



  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Padding(
        padding:  EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: Form(key: _formKeyLogin,
          child: SingleChildScrollView(
            child: Column(
            children: [
              SizedBox(height: Dimensions.topSpace),
              Padding(padding:  EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Image.asset(Images.ipositalogo,
                  height: 50, fit: BoxFit.scaleDown, matchTextDirection: true,
                ),
              ),
              Center(
                  child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppConstants.appName, style: rubikMedium.copyWith(
                              fontSize: Dimensions.fontSizeLarge)),
                          Text(' APP', style: rubikMedium.copyWith(
                              fontSize: Dimensions.fontSizeLarge, color: Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) :
                          Theme.of(context).primaryColor)),
                        ],
                      ),
                      SizedBox(height: Dimensions.paddingSizeDefault),
                      Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('${'welcome_to'.tr} ${AppConstants.companyName}', style: rubikMedium.copyWith(
                              fontSize: Dimensions.fontSizeExtraLarge,
                              color:Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor)),
                          SizedBox(width: 40, child: Image.asset(Images.hand))
                        ],
                      ),
                    ],
                  )),
              SizedBox(height: Dimensions.loginSpace),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                      Text('login'.tr, style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge,
                          color:Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor)),
                      SizedBox(height: Dimensions.fontSizeExtraSmall),
                      Text('Join IPOSITA mail management version 3'.tr,style: rubikRegular.copyWith(color: Theme.of(context).hintColor)),
                    ],),
                    SizedBox(height: Dimensions.topSpace),

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
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
                          borderRadius: BorderRadius.circular(Dimensions.topSpace)
                      ),
                      child: Stack(
                        children: [
                          Container(width: 59, height: 53, decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(.125),
                              borderRadius:  Get.find<LocalizationController>().isLtr?
                              BorderRadius.only(
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
                                Padding(
                                  padding: const EdgeInsets.only(bottom : 4.0),
                                  child: SizedBox(width: 59,height: 20, child: Image.asset(Images.lock)),
                                ),
                                Expanded(
                                  child: CustomTextField(
                                    hintText: 'password_hint'.tr,
                                    isPassword: true,
                                    isShowSuffixIcon: true,
                                    focusNode: _passwordFocus,
                                    noPadding: true,
                                    controller: _passwordController,
                                    inputAction: TextInputAction.done,

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.paddingSizeLarge),
                    Padding(
                      padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, 0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            // onTap: ()  => authController.toggleRememberMe(),
                            child: Row(
                              children: [
                                Container(width: Dimensions.rememberMeSizeDefault, height: Dimensions.rememberMeSizeDefault,
                                  decoration: BoxDecoration(color:Colors.blue != null ?
                                  Theme.of(context).primaryColor : ColorResources.colorWhite,
                                      border: Border.all(color: Colors.blueGrey != null ?
                                      Colors.transparent : Theme.of(context).highlightColor),
                                      borderRadius: BorderRadius.circular(3)),
                                  child:
                                  Icon(Icons.done, color: ColorResources.colorWhite,
                                      size: Dimensions.rememberMeSizeDefault),
                                  //:
                                  // const SizedBox.shrink(),
                                ),
                                SizedBox(width: Dimensions.paddingSizeSmall),

                                Text('remember_me'.tr, style: Theme.of(context).textTheme.headline2.copyWith(
                                    fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).highlightColor),),

                              ],
                            ),
                          ),
                          GestureDetector(
                              onTap: (){
                               Get.to(const ForgetPasswordScreen());
                              },
                              child: Text('forget_password'.tr,
                                style: rubikRegular.copyWith(color: Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) :Theme.of(context).primaryColor,
                                    decoration: TextDecoration.underline),)),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.paddingSizeLarge),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width/3.5),
                      child: CustomButton(
                        btnTxt: 'login'.tr,
                        onTap: () async {
                          String countryCode =  _countryDialCode.replaceAll('+', '');
                          String phone = _emailController.text.trim();
                          String _password = _passwordController.text.trim();
                          if (phone.isEmpty) {
                            showCustomSnackBar('Enter Your Email Please'.tr);
                          }else if (_password.isEmpty) {
                            showCustomSnackBar('enter_password'.tr);
                          }else if (_password.length < 6) {
                            showCustomSnackBar('password_should_be'.tr);
                          }else {
                            _login();
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        Dimensions.paddingSizeDefault,
                        0,
                        Dimensions.paddingSizeDefault,
                        0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              child: Row(
                                children: [
                                  SizedBox(width: Dimensions.paddingSizeSmall),
                                  Expanded(
                                    child: Text(
                                      "Don't have an account ?".tr,
                                      style: Theme.of(context).textTheme.displayMedium.copyWith(
                                        fontSize: Dimensions.fontSizeExtraLarge,
                                        color: Theme.of(context).highlightColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(const RegisterScreen());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                'Register'.tr,
                                style: rubikRegular.copyWith(
                                  color: Get.isDarkMode
                                      ? Theme.of(context).hintColor.withOpacity(.5)
                                      : Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    _isLoading ? Center(child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    )):const Center(child: SizedBox(width: 0,),),
                    GestureDetector(
                      onTap: (){

                        // Get.to(()=> HtmlViewScreen(title: 'terms_and_conditions'.tr,
                        //     url: Get.find<SplashController>().configModel.termsConditions));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('terms_and_conditions'.tr,
                              style: rubikRegular.copyWith(color:Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor, decoration: TextDecoration.underline),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
            ),
          ),
        ),
      ),
    );
  }
  void _login() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'email': _emailController.text.toString(),
      'password': _passwordController.text.toString(),
    };

    var res = await CallApi().postData(data, AppConstants.driverLoginUri);
    if (res == null) {
      // Handle the case where the response is null
      print('Error: Failed to fetch response');
      setState(() {
        _isLoading = false;
      });
      return;
    }
    else {
      var body = json.decode(res.body);
        print(body);
      if (body['success']==true) {
        print(body['token']);
        // print(body['user']);
        SharedPreferences localStorage = await SharedPreferences.getInstance();
       localStorage.setString('token', body['token']);
        localStorage.setString('user', json.encode(body['user']));
        localStorage.setBool("isCustomerLogin", false);
        var userJson=localStorage.getString("user");
        var user=json.decode(userJson);
        print(user['id']);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (_) => const DashboardScreen(pageIndex: 0)),
        );
      } else {

        var res1 = await CallApi().customerLogin(data, AppConstants.customerLoginUri);
        if (res1 == null) {
          // Handle the case where the response is null
          print('Error: Failed to fetch response');
          setState(() {
            _isLoading = false;
          });
          return;
        }
        else {
          var body = json.decode(res1.body);
          if (body['success']==true) {
            print(body['token']);
            // print(body['user']);
            SharedPreferences localStorage = await SharedPreferences.getInstance();
            localStorage.setString('token', body['token']);
            localStorage.setString('user', json.encode(body['user']));
            //make sure customer is logged in
            localStorage.setBool("isCustomerLogin", true);
            var userJson=localStorage.getString("user");
            var user=json.decode(userJson);
            print(user['id']);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (_) => const DashboardScreen1(pageIndex: 0)),
            );
          } else {
            setState(() {
              _isLoading = false;
            });
            showCustomSnackBar(body['message']);
          }
        }
      }
    }
  }

}
