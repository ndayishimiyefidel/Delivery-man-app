import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/online_offline_button.dart';


class CustomRiderAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBack;
  final Function onTap;
  final bool isSwitch;

  const CustomRiderAppBar({Key key, this.title, this.isBack = false, this.onTap, this.isSwitch  = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).cardColor,
      leading: isBack? GestureDetector(onTap: onTap ?? ()=>Get.back(),
          child: Icon(Icons.arrow_back_ios,color: Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor)):
      Padding(
        padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),
       // child: Image.asset(Images.ipositalogo, height: 30, width: 30,),
      ),
      titleSpacing: 0,
      elevation: 1,
      title: Text(title.tr, maxLines: 1, overflow: TextOverflow.ellipsis, style: rubikMedium.copyWith(
        color: Theme.of(context).textTheme.bodyText1.color, fontSize: Dimensions.fontSizeExtraLarge,
      )),
      actions:  [
        isSwitch?
        const OnlineOfflineButton(): const SizedBox(),
         SizedBox(width: Dimensions.paddingSizeSmall),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(1170, 50);
}