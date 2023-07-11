import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';

class CustomActionButton extends StatelessWidget {
  final String title;
  final Function onTap;
  const CustomActionButton({Key key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
            color: Theme.of(context).primaryColor.withOpacity(.1),
            border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5),width: .5)),
        child: Text(title.tr),
      ),
    );
  }
}
