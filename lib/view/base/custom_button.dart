import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/utill/color_resources.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String btnTxt;
  final bool isShowBorder;
  final bool transparent;
  final bool withIcon;
  final IconData icon;

  const CustomButton({Key key, this.onTap, @required this.btnTxt, this.isShowBorder = false, this.transparent = false, this.withIcon = false, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: !isShowBorder ?Get.isDarkMode? Theme.of(context).primaryColor.withOpacity(.5) : Colors.grey.withOpacity(0.2) : Colors.transparent,
                spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))],
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: isShowBorder && !transparent ? ColorResources.colorGreyWhite : Colors.transparent),
            color: !isShowBorder ? Theme.of(context).primaryColor : Colors.transparent),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            withIcon?
            Icon(icon,color: Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).cardColor) : const SizedBox(),
            TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
              child: Text(btnTxt ?? "",
                  style: Theme.of(context).textTheme.headline3.copyWith(
                      color:Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : isShowBorder ? Theme.of(context).textTheme.bodyText1.color :
                      Theme.of(context).primaryColorDark, fontSize: Dimensions.fontSizeLarge)),
            ),
          ],
        ),
      ),
    );
  }
}
