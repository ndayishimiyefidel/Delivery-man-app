import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final Function onYesPressed;
  final bool isLogOut;
  final bool hasCancel;
   const ConfirmationDialog({Key key, @required this.icon, this.title, @required this.description, @required this.onYesPressed, this.isLogOut = false, this.hasCancel = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      child: Padding(
        padding:  EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Padding(
            padding:  EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Image.asset(icon, width: 50, height: 50),
          ),

          title != null ? Padding(
            padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            child: Text(
              title, textAlign: TextAlign.center,
              style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.red),
            ),
          ) :  const SizedBox(),

          Padding(
            padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Text(description, style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge), textAlign: TextAlign.center),
          ),
           SizedBox(height: Dimensions.paddingSizeLarge),

          Row(children: [
            hasCancel ? Expanded(child: TextButton(
              onPressed: () => isLogOut ? onYesPressed() : Get.back(),
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize:  const Size(1170, 50), padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeOverLarge)),
              ),
              child: Text(
                isLogOut ? 'yes'.tr : 'no'.tr, textAlign: TextAlign.center,
                style: rubikRegular.copyWith(color: Theme.of(context).textTheme.bodyText1.color),
              ),
            )) :  const SizedBox(),
            SizedBox(width: hasCancel ? Dimensions.paddingSizeLarge : 0),

            Expanded(child: CustomButton(
              btnTxt: isLogOut ? 'no'.tr : hasCancel ? 'yes'.tr : 'ok'.tr,
              onTap: () => isLogOut ? Get.back() : onYesPressed(),
            )),
          ])

        ]),
      ),
    );
  }
}