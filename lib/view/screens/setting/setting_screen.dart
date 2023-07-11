import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/language_controller.dart';
import 'package:sixvalley_delivery_boy/controller/localization_controller.dart';
import 'package:sixvalley_delivery_boy/controller/theme_controller.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/screens/language/choose_language_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Theming _theming;

  @override
  void initState() {
    if(!Get.isDarkMode){
      _theming = Theming.light;
    }else{
      _theming =  Theming.dark;
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRiderAppBar(title: 'setting'.tr, isBack: true),
      body: Column(children: [

        GestureDetector(
          onTap: ()=> Get.to(()=> const ChooseLanguageScreen()),
          child: Padding(
            padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              Row(children: [
                SizedBox(width: Dimensions.iconSizeDefault,
                    child: Image.asset(Images.languageIcon)),
                SizedBox(width: Get.find<LocalizationController>().isLtr? 0: Dimensions.paddingSizeSmall),
                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                  child: Text('language'.tr),
                )
              ],),
              Text(AppConstants.languages[Get.find<LanguageController>().selectIndex].languageName),
            ],),
          ),
        ),
        Padding(
          padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault),
          child: Row(children: [
            SizedBox(width: Dimensions.iconSizeDefault,
                child: Image.asset(Images.themeIcon)),
            SizedBox(width: Get.find<LocalizationController>().isLtr? 0: Dimensions.paddingSizeSmall),
            Padding(
              padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall),
              child: Text('theme'.tr),
            )
          ],),
        ),

        GetBuilder<ThemeController>(
          builder: (theme) {
            return SizedBox(height: 50,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                Row(
                  children: [
                    Radio<Theming>(
                      activeColor: Theme.of(context).primaryColor,
                      value: Theming.light,
                      groupValue: _theming,
                      onChanged: (Theming value) {
                        theme.toggleTheme();
                        _theming = Theming.light;
                      },
                    ),
                    Text('light'.tr),

                  ],
                ),
                Row(
                  children: [
                    Radio<Theming>(
                      activeColor: Theme.of(context).primaryColor,
                      value: Theming.dark,
                      groupValue: _theming,
                      onChanged: (Theming value) {
                        theme.toggleTheme();
                        _theming = Theming.dark;
                      },
                    ),
                    Text('dark'.tr),


                  ],
                ),
              ],
              ),
            );
          }
        )


      ],),
    );
  }
}


enum Theming {light, dark }

