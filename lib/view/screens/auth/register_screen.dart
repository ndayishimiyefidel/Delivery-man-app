import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/view/screens/auth/login_screen.dart';
import '../../../controller/localization_controller.dart';
import '../../../mobileapi/api.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../../base/custom_button.dart';
import '../../base/custom_snackbar.dart';
import '../../base/custom_text_field.dart';
import '../dashboard/dashboard_screen.dart';
import '../dashboard/dashboard_screen1.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}


class _RegisterScreenState extends State<RegisterScreen> {
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  TextEditingController _nameController;
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
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: GestureDetector(child: const Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,size: 30,), onTap:(){
        Get.to(const LoginScreen());
      },),
      centerTitle: true,title: const Text("Customer Registration",style: TextStyle(color: Colors.black38),),
        backgroundColor: Theme.of(context).canvasColor,elevation: 5,),
      backgroundColor: Theme.of(context).canvasColor,
      body: Padding(
        padding:  EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: Form(key: _formKeyLogin,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Dimensions.topSpace),
                Padding(padding:  EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Image.asset(Images.guestLogin,
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
                            Text('Register as customer/client'.tr, style: rubikMedium.copyWith(
                                fontSize: Dimensions.fontSizeExtraLarge,
                                color:Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor)),
                            SizedBox(width: 40, child: Image.asset(Images.hand))
                          ],
                        ),
                      ]
                    )),
                SizedBox(height: Dimensions.loginSpace),
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
                              child: SizedBox(width: 59,height: 20, child: Icon(Icons.person,color: Colors.blueAccent,size: 25,)),
                            ),
                            Expanded(
                              child: CustomTextField(
                                hintText: 'Joe Doe',
                                noPadding: true,
                                nextFocus: _nameFocus,
                                controller: _nameController,
                                focusNode: _nameFocus,
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
                                inputType: TextInputType.emailAddress,
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
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width/3.5),
                  child: CustomButton(
                    btnTxt: 'Register'.tr,
                    onTap: () async {
                      String countryCode =  _countryDialCode.replaceAll('+', '');
                      String _email = _emailController.text.trim();
                      String _password = _passwordController.text.trim();
                      String _name=_nameController.text.trim();
                       if(_name.isEmpty) {
                      showCustomSnackBar('Enter Your name Please'.tr);
                      }
                     else if (_email.isEmpty) {
                        showCustomSnackBar('Enter Your Email Please'.tr);
                      }else if (_password.isEmpty) {
                        showCustomSnackBar('enter_password'.tr);
                      }else if (_password.length < 6) {
                        showCustomSnackBar('password_should_be'.tr);
                      }
                      else{
                        _register();
                      }
                    },
                  ),
                ),

                const SizedBox(height: 5,),
                _isLoading ? Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                )):const Center(child: SizedBox(width: 0,),),
                Padding(
                  padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, 0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Row(
                          children: [
                            SizedBox(width: Dimensions.paddingSizeSmall),
                            Text("Already have account ?".tr, style: Theme.of(context).textTheme.headline2.copyWith(
                                fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).highlightColor),),
                          ],
                        ),
                      ),

                      GestureDetector(
                          onTap: (){
                            Get.to(const LoginScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text('Login'.tr,
                              style: rubikRegular.copyWith(color: Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) :Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline),),
                          )),
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

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'name':_nameController.text.trim(),
      'email': _emailController.text.trim(),
      'password': _passwordController.text.trim(),
    };

    var res = await CallApi().customerRegister(data, AppConstants.customerRegisterUri);
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
