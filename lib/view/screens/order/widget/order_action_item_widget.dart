import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:get/get.dart';

class OrderActionItem extends StatelessWidget {
  final String icon;
  final String title;
  final Function onTap;
  const OrderActionItem({Key key, this.icon, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> onTap(),
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(padding:  EdgeInsets.all(Dimensions.paddingSizeDefault),
                width: 50, height:50, decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(.75),
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                  boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.125),
                      blurRadius: 5, spreadRadius: 1)],
                ),child: SizedBox(width: 20, child: Image.asset(icon))),
             SizedBox(height: Dimensions.paddingSizeSmall),
            Text(title.tr),

          ],),
        ),
      ),
    );
  }
}