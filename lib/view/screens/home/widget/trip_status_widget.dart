import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sixvalley_delivery_boy/controller/menu_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/screens/dashboard/dashboard_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/physical_pob.dart';

import '../../dashboard/dashboard_screen1.dart';
import '../../mails/carburation_screen.dart';
import '../../mails/international_mails.dart';
import '../../mails/mail_screen.dart';
import '../../mails/national_mails.dart';
import '../driver_home_delivery.dart';

class TripStatusWidget extends StatelessWidget {
  final Function(int index) onTap;
  final int countNational,countInternational,countHomeDelivery;
  const TripStatusWidget({Key key, @required this.onTap, this.countNational, this.countInternational, this.countHomeDelivery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeExtraSmall),
      // child: GetBuilder<ProfileController>(
      //   builder: (profileController) {
         child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            Padding(
              padding:  EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
              child: Text('Mail Status'.tr,style:  rubikMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
                  color: Theme.of(context).colorScheme.secondary)),
            ),
            GestureDetector(
              onTap: ()=> Get.to(()=> const DashboardScreen(pageIndex: 1)),
              child: TripItem(color: Theme.of(context).colorScheme.tertiaryContainer,icon: Images.assigned,
                  title: 'PICK UP EMS NATIONAL', totalCount: countNational,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const NationalMails();
                  }));

                },),
            ),

            TripItem(color: Theme.of(context).colorScheme.surface, icon: Images.pending,
                title: 'PICK UP MAIL AT AIRPORT',totalCount: countInternational,
                //profileController.profileModel.pendingDelivery,
              onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const InternationalMail();
                  }));
                }
            ),

            TripItem(color: Theme.of(context).colorScheme.primaryContainer,icon: Images.completed,
                title: 'HOME DELIVERY', totalCount: countHomeDelivery,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return const DriverHomeDeliveryRequest();
                }));
              }),
           const SizedBox(height: 20,),
           TripModifiedItem(color: Theme.of(context).colorScheme.primary,icon: Images.location,
               title: 'CARNE DE ROUTE',
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context){
                   return const ConversationScreen();
                 }));
               }),
           TripModifiedItem(color: Theme.of(context).colorScheme.onSecondary,icon: Images.cash,
               title: 'CAR CONSUMPTION',
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context){
                   return const CarburationScreen();
                 }));
               }),


          ],),
      //   }
      // ),
    );
  }
}
class TripStatusModifiedWidget extends StatelessWidget {
  final Function(int index) onTap;
  const TripStatusModifiedWidget({Key key, @required this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeExtraSmall),

      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Padding(
          padding:  EdgeInsets.only(bottom: Dimensions.paddingSizeSmall,top: 20,),
          child: Text('P.O Box Management'.tr,style:  rubikMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
              color: Theme.of(context).colorScheme.secondary)),
        ),
        GestureDetector(
          onTap: ()=> Get.to(()=> const DashboardScreen1(pageIndex: 1)),
          child: TripModifiedItem(color: Theme.of(context).colorScheme.tertiaryContainer,icon: Images.orderInfo,
            title: 'P.O. Box Information',
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return const PhysicalPob();
              }));

            },),
        ),
        const SizedBox(height: 20,),

        TripModifiedItem(color: Theme.of(context).colorScheme.surface, icon: Images.money,
            title: 'P.O Box Payments',
            onTap: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return const PhysicalPob();
              }));
            }
        ),

        const SizedBox(height: 20,),

      ],),
      //   }
      // ),
    );
  }
}

class TripItem extends StatelessWidget {
  final Color color;
  final String icon;
  final String title;
  final int totalCount;
  final Function onTap;
  const TripItem({Key key, this.icon, this.title, this.totalCount, this.color, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
        child: Container(decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          color: color.withOpacity(.55)),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
             Container(padding:  EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
               child: Row(children: [
                Padding(
              padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: SizedBox(width: 30,child: Image.asset(icon)),
            ),
                Text(title.tr, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w400),),
               ],),),
              Padding(
            padding:  EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall),
            child: Container(padding:  EdgeInsets.symmetric(vertical : Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeLarge),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              color: color.withOpacity(.75)
            ),child: Text(NumberFormat.compact().format(totalCount),style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge),),),
          )
        ],)),
      ),
    );
  }
}


class TripModifiedItem extends StatelessWidget {
  final Color color;
  final String icon;
  final String title;
  final Function onTap;
  const TripModifiedItem({Key key, this.icon, this.title,  this.color, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
        child: Container(decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            color: color.withOpacity(.55)),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              Container(padding:  EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
                child: Row(children: [
                  Padding(
                    padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: SizedBox(width: 30,child: Image.asset(icon)),
                  ),
                  Text(title.tr, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w400),),
                ],),),
            ],)),
      ),
    );
  }
}
class TripModified1Item extends StatelessWidget {
  final Color color;
  final String icon;
  final String title;
  final Function onTap;
  const TripModified1Item({Key key, this.icon, this.title,  this.color, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
        child: Container(decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            color: color.withOpacity(.55)),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              Container(padding:  EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
                child: Row(children: [
                  Padding(
                    padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: SizedBox(width: 30,child: Image.asset(icon)),
                  ),
                  Text(title.tr, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w400),),
                ],),),
            ],)),
      ),
    );
  }
}