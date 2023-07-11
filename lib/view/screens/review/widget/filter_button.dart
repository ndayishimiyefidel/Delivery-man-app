
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/localization_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';

class FilterButtonWidget extends StatelessWidget {
  final String type;
  final List<String> items;
  final bool isBorder;
  final bool isSmall;
  final Function(String value) onSelected;

  const FilterButtonWidget({Key key,
    @required this.type, @required this.onSelected, @required this.items,  this.isBorder = false, this.isSmall = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _ltr = Get.find<LocalizationController>().isLtr;
    return  Align(alignment: Alignment.center, child: Container(
      height:  60,
      padding : EdgeInsets.all(Dimensions.paddingSizeSmall, ),
      margin: EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration:  BoxDecoration(
        color: Theme.of(context).hintColor.withOpacity(.125),
        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),

      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onSelected(items[index]),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              margin: isBorder ? EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall) : EdgeInsets.zero,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: isBorder ? BorderRadius.all(Radius.circular(Dimensions.radiusSmall)) : BorderRadius.horizontal(
                  left: Radius.circular(
                    _ltr ? index == 0 && items[index] != type ? Dimensions.radiusSmall : 0
                        : index == items.length-1
                        ? Dimensions.radiusSmall : 0,
                  ),
                  right: Radius.circular(
                    _ltr ? index == items.length-1 &&  items[index] != type
                        ? Dimensions.radiusSmall : 0 : index == 0
                        ? Dimensions.radiusSmall : 0,
                  ),
                ),
                color: items[index] == type ? Theme.of(context).primaryColor
                    : Colors.transparent,

              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  items[index].tr,
                  style: items[index] == type
                      ? rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.white)
                      : rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor),
                ),
              ),
            ),
          );
        },
      ),
    ));
  }
}

