import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/splash_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_button.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRiderAppBar(title: 'help_and_support'.tr, isBack: true,),
      body: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Padding(
          padding:  EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
          child: Center(
            child: SizedBox(
              width: 200,
              child: Image.asset(Images.support),
            ),
          ),
        ),

       Padding(
         padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeDefault),
         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
           Padding(
             padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
             child: Text('contact_us_through_email'.tr, style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
           ),

           Padding(
             padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
             child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
               Text('you_can_send_us_email_through'.tr, style: rubikRegular.copyWith(color: Theme.of(context).hintColor)),
               Text(Get.find<SplashController>().configModel.companyEmail,
                 style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
               Padding(
                 padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                 child: Text.rich(
                     TextSpan(
                       children: [
                         TextSpan(text: 'typically_support_team_send_you_feedback'.tr, style: rubikRegular.copyWith(color: Theme.of(context).hintColor)),
                         TextSpan(
                           text: 'two_hours'.tr,
                           style: rubikMedium,
                         ),

                       ],
                     ),
                   )
               ),
             ],),
           ),

           Padding(
             padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
             child: Text('contact_us_through_phone'.tr, style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
           ),

           Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

             Padding(
               padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
               child: Text.rich(
                 TextSpan(
                   children: [
                     TextSpan(text: 'contact_with_us'.tr, style: rubikRegular.copyWith(color: Theme.of(context).hintColor)),
                      TextSpan(
                       text: Get.find<SplashController>().configModel.companyPhone,
                       style: rubikMedium,
                     ),
                   ],
                 ),
               ),
             ),


             Text.rich(
               TextSpan(
                 children: [
                   TextSpan(text: 'talk_with_our'.tr, style: rubikRegular.copyWith(color: Theme.of(context).hintColor)),
                   TextSpan(
                     text: 'customer_support_executive'.tr,
                     style: rubikMedium,
                   ),
                   TextSpan(text: 'at_any_time'.tr, style: rubikRegular.copyWith(color: Theme.of(context).hintColor)),
                 ],
               ),
             )
           ],),
         ],),
       ),
         SizedBox(height: Dimensions.splashLogoWidth),

        Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeOverLarge),
          child: Row(children: [
            Expanded(child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: CustomButton(btnTxt: 'email'.tr,withIcon: true,icon: Icons.email,
              onTap: ()=> _launchUrl("sms:${Get.find<SplashController>().configModel.companyEmail}",true),),
            )),
            Expanded(child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: CustomButton(btnTxt: 'call'.tr,withIcon: true,icon: Icons.call,onTap: (){
                _launchUrl("tel:${Get.find<SplashController>().configModel.companyPhone}",false);
              },),
            )),
          ],),
        )

      ],),),
    );
  }
}

final Uri params = Uri(
  scheme: 'mailto',
  path: Get.find<SplashController>().configModel.companyEmail,
  query: 'subject=support Feedback&body=',
);


Future<void> _launchUrl(String _url, bool isMail) async {
  if (!await launchUrl(Uri.parse(isMail? params.toString() :_url))) {
    throw 'Could not launch $_url';
  }
}
