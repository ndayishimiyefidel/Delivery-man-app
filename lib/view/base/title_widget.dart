import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final Function onTap;

  const TitleWidget({Key key, @required this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title, style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
          color: Theme.of(context).colorScheme.secondary)),
      onTap != null ? GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
          child: Container(decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
            border: Border.all(color: Get.isDarkMode? Theme.of(context).primaryColorLight :Theme.of(context).primaryColor.withOpacity(.25))
          ),
            padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: Dimensions.paddingSizeExtraSmall),
            child: Text('view_all'.tr,
              style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
            ),
          ),
        ),
      ) : const SizedBox(),
    ]);
  }
}
