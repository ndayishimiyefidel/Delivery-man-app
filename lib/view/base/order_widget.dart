// import 'package:efood_multivendor_driver/data/model/response/order_model.dart';
// import 'package:efood_multivendor_driver/helper/route_helper.dart';
// import 'package:efood_multivendor_driver/util/dimensions.dart';
// import 'package:efood_multivendor_driver/util/images.dart';
// import 'package:efood_multivendor_driver/util/styles.dart';
// import 'package:efood_multivendor_driver/view/base/custom_button.dart';
// import 'package:efood_multivendor_driver/view/base/custom_snackbar.dart';
// import 'package:efood_multivendor_driver/view/screens/order/order_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class OrderWidget extends StatelessWidget {
//   final OrderModel orderModel;
//   final bool isRunningOrder;
//   final int orderIndex;
//   OrderWidget({@required this.orderModel, @required this.isRunningOrder, @required this.orderIndex});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
//       padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
//         boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], blurRadius: 5, spreadRadius: 1)],
//       ),
//       child: Column(children: [
//
//         Row(children: [
//           Text('${'order_id'.tr}:', style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
//           SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//           Text('#${orderModel.id}', style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
//           Expanded(child: SizedBox()),
//           Container(width: 7, height: 7, decoration: BoxDecoration(
//             color: orderModel.paymentMethod == 'cash_on_delivery' ? Colors.red : Colors.green,
//             shape: BoxShape.circle,
//           )),
//           SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//           Text(
//             orderModel.paymentMethod == 'cash_on_delivery' ? 'cod'.tr : 'digitally_paid'.tr,
//             style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
//           ),
//         ]),
//         SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
//
//         Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: [
//           Image.asset(orderModel.orderStatus == 'picked_up' ? Images.user : Images.house, width: 20, height: 15),
//           SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//           Text(
//             orderModel.orderStatus == 'picked_up' ? 'customer_location'.tr :'restaurant_location'.tr,
//             style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
//             maxLines: 1, overflow: TextOverflow.ellipsis,
//           ),
//         ]),
//         SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//
//         Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: [
//           Icon(Icons.location_on, size: 20),
//           SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//           Expanded(child: Text(
//             orderModel.deliveryAddress.address.toString(),
//             style: robotoRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.FONT_SIZE_SMALL),
//             maxLines: 1, overflow: TextOverflow.ellipsis,
//           )),
//         ]),
//         SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
//
//         Row(children: [
//           Expanded(child: TextButton(
//             onPressed: () {
//               Get.toNamed(
//                 RouteHelper.getOrderDetailsRoute(orderModel.id),
//                 arguments: OrderDetailsScreen(orderModel: orderModel, isRunningOrder: isRunningOrder, orderIndex: orderIndex),
//               );
//             },
//             style: TextButton.styleFrom(minimumSize: Size(1170, 45), padding: EdgeInsets.zero, shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), side: BorderSide(width: 2, color: Theme.of(context).disabledColor),
//             )),
//             child: Text('details'.tr, textAlign: TextAlign.center, style: robotoBold.copyWith(
//               color: Theme.of(context).disabledColor, fontSize: Dimensions.FONT_SIZE_LARGE,
//             )),
//           )),
//           SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
//           Expanded(child: CustomButton(
//             height: 45,
//             onPressed: () async {
//               String _url;
//               if(orderModel.orderStatus == 'picked_up') {
//                 _url = 'https://www.google.com/maps/dir/?api=1&destination=${orderModel.deliveryAddress.latitude}'
//                     ',${orderModel.deliveryAddress.longitude}&mode=d';
//               }else {
//                 _url = 'https://www.google.com/maps/dir/?api=1&destination=${orderModel.restaurantLat}'
//                     ',${orderModel.restaurantLng}&mode=d';
//               }
//               if (await canLaunch(_url)) {
//                 await launch(_url);
//               } else {
//                 showCustomSnackBar('${'could_not_launch'.tr} $_url');
//               }
//             },
//             buttonText: 'direction'.tr,
//             icon: Icons.directions,
//           )),
//         ]),
//
//       ]),
//     );
//   }
// }
