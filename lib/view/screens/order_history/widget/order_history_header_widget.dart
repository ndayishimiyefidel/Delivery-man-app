import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_search_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/widget/order_type_button.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/widget/transaction_search_filter_widget.dart';


class OrderHistoryHeaderWidget extends StatefulWidget {
  const OrderHistoryHeaderWidget({Key key}) : super(key: key);

  @override
  State<OrderHistoryHeaderWidget> createState() => _OrderHistoryHeaderWidgetState();
}

class _OrderHistoryHeaderWidgetState extends State<OrderHistoryHeaderWidget> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    // return GetBuilder(
    //   builder: (orderController) {
        return Container(
          height: 200,decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius:  BorderRadius.only(bottomLeft: Radius.circular(Dimensions.paddingSizeOverLarge),
              bottomRight: Radius.circular(Dimensions.paddingSizeOverLarge))),
          padding:  EdgeInsets.only(top : Dimensions.paddingSizeSmall),
          child: Column(children: [
            // GetBuilder(
            // builder: (order) {
               Padding(
                padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,
                    Dimensions.fontSizeExtraSmall, Dimensions.paddingSizeDefault,5),
                child: Container(height: 48,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(Dimensions.flagSize),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 48, right: 10),
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              OrderTypeButton(text: 'all'.tr, index: 0),

                              OrderTypeButton(text: 'out_for_delivery'.tr, index: 1),

                              OrderTypeButton(text: 'paused'.tr, index: 2),

                              OrderTypeButton(text: 'delivered'.tr, index: 3),

                              OrderTypeButton(text: 'return'.tr, index: 4),

                              OrderTypeButton(text: 'canceled'.tr, index: 5),


                            ],
                          ),
                        ),
                        AnimSearchBar(
                          width: MediaQuery.of(context).size.width,
                          textController: textController,
                          onSuffixTap: () {
                            textController.clear();
                          },
                          onChanged: (value){
                            if(value != null){
                              // orderController.setOrderTypeIndex(orderController.orderTypeIndex,
                              //     search: textController.text);
                            }
                          },

                          color: Theme.of(context).cardColor,
                          helpText: "Search Text...",
                          autoFocus: true,
                          closeSearchOnSuffixTap: true,
                          animationDurationInMilli: 200,
                          rtl: false,
                        ),
                      ],
                    )),
              ),
          //   }
          // ),
            const DeliverySearchFilterWidget(fromHistory : true),

        ],),);
    //   }
    // );
  }
}
