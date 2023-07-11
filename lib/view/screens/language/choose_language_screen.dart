import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/language_controller.dart';
import 'package:sixvalley_delivery_boy/controller/localization_controller.dart';
import 'package:sixvalley_delivery_boy/data/model/response/language_model.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_button.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_snackbar.dart';
import 'package:sixvalley_delivery_boy/view/screens/dashboard/dashboard_screen.dart';


class ChooseLanguageScreen extends StatelessWidget {
  final bool fromHomeScreen;
  const ChooseLanguageScreen({Key key, this.fromHomeScreen = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<LanguageController>().initializeAllLanguages(context);

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<LanguageController>(
          builder: (languageController){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: Dimensions.topSpace),


                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall,
                      top: Dimensions.paddingSizeSmall),
                  child: Text('choose_the_language'.tr,
                    style: rubikRegular.copyWith(
                        fontSize: Dimensions.fontSizeHeading, color: Theme.of(context).highlightColor),),
                ),
                 SizedBox(height: Dimensions.topSpace),


                Expanded(child: ListView.builder(
                    itemCount: languageController.languages.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => _languageWidget(
                        context: context, languageModel: languageController.languages[index],
                        languageController: languageController, index: index))),


                Padding(padding:  EdgeInsets.only(
                      left: Dimensions.paddingSizeLarge,
                    right: Dimensions.paddingSizeLarge,
                    bottom: Dimensions.paddingSizeLarge),


                  child: CustomButton(btnTxt: 'save'.tr,
                    onTap: () {
                      if(languageController.languages.isNotEmpty && languageController.selectIndex != -1) {
                        Get.find<LocalizationController>().setLanguage(Locale(
                          AppConstants.languages[languageController.selectIndex].languageCode,
                          AppConstants.languages[languageController.selectIndex].countryCode,
                        ));
                        if (fromHomeScreen) {
                          Navigator.pop(context);
                        } else {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) =>  const DashboardScreen(pageIndex: 0)));
                        }
                      }else {
                        showCustomSnackBar('select_a_language'.tr);
                      }
                    },
                  ),
                )
              ],
            );
          },

        ),
      ),
    );
  }

  Widget _languageWidget({BuildContext context, LanguageModel languageModel,
    LanguageController languageController, int index}) {
    return InkWell(
      onTap: ()  => languageController.setSelectIndex(index),

      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
        decoration: BoxDecoration(
          color: languageController.selectIndex == index ?
          Theme.of(context).primaryColor.withOpacity(.15) : null,
          border: Border(top: BorderSide(
                  width: languageController.selectIndex == index ? 1.0 : 0.0,
                  color: languageController.selectIndex == index ?
                  Theme.of(context).primaryColor : Colors.transparent),

              bottom: BorderSide(
                  width: languageController.selectIndex == index ? 1.0 : 0.0,
                  color: languageController.selectIndex == index ?
                  Theme.of(context).primaryColor : Colors.transparent)),),


        child: Container(
          padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1.0,
                    color: languageController.selectIndex == index ?
                    Colors.transparent :
                    (languageController.selectIndex - 1) == (index - 1) ?
                    Colors.transparent :
                    Theme.of(context).dividerColor.withOpacity(.2))),),



          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(languageModel.imageUrl, width: Dimensions.flagSize,
                      height: Dimensions.flagSize),
                   SizedBox(width: Dimensions.topSpace),


                  Text(languageModel.languageName,
                    style: rubikRegular.copyWith(
                        color: Theme.of(context).textTheme.bodyText1.color),
                  ),
                ],
              ),


              languageController.selectIndex == index ?
              Image.asset(Images.done, width: Dimensions.iconSizeDefault,
                height: Dimensions.iconSizeDefault,
                color: Theme.of(context).primaryColorLight,) :
              const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
