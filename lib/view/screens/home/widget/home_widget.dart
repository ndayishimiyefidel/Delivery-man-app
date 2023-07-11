import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/physical_pob.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/virtual_pob.dart';

import '../../order_history/view_customer_address.dart';
import '../cusomer_international.dart';
import '../customer_national_mail.dart';
import '../home_delivery_request.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.5,
      child: ListView(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.black12,
          ),
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector( child: regularCard('assets/map.svg', 'Mails',Theme.of(context).colorScheme.primaryContainer,),
                      onTap: (){
                      //go to mail
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return  const CustomerInternationalMails();
                        }));

                      },
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return  const CustomerNationalMail();
                        }));
                      },
                      child: regularCard1(
                          'assets/ems_adobe_express.svg', 'EMS National',Colors.white,),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return  const PhysicalPob();
                        }));
                      },
                        child: regularCard('assets/poboxmail.svg', 'P.O Box',Theme.of(context).colorScheme.outline,)),
                  ]),
              const SizedBox(height: 40),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return  const VirtualPob();
                          }));
                        },
                        child: regularCard1('assets/virtual_adobe_express.svg', 'Virtual P.O Box',Colors.white,)),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return  const CustomerVirtualAddress();
                          }));
                        },
                        child: regularCard('assets/address.svg', 'Virtual Address',Theme.of(context).colorScheme.onTertiaryContainer)),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return  const HomeDeliveryRequest();
                          }));
                        },
                        child: regularCard('assets/homedelive.svg', 'Home Delivery',Theme.of(context).colorScheme.primaryContainer,)),
                  ],),

            ]),
          ),
        ),
      ]),
    );
  }

  SizedBox regularCard(String iconName, String cardLabel, Color color,) {
    return SizedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color,
            boxShadow: [
              BoxShadow(
                  color: color, offset: Offset.zero, blurRadius: 20)
            ],
          ),
          child: SvgPicture.asset(iconName, width: 50,),
        ),
        const SizedBox(height: 5),
        Text(cardLabel,
            textAlign: TextAlign.center,
            style: textStyle(14, FontWeight.w600, Colors.black))
      ]),
    );
  }

  SizedBox regularCard1(String iconName, String cardLabel, Color color,) {
    return SizedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          height: 110,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color,
            boxShadow: [
              BoxShadow(
                  color: color, offset: Offset.zero, blurRadius: 20)
            ],
          ),
          child: SvgPicture.asset(iconName, width: 50,),
        ),
        const SizedBox(height: 5),
        Text(cardLabel,
            textAlign: TextAlign.center,
            style: textStyle(14, FontWeight.w600, Colors.black))
      ]),
    );
  }



  Container mainCard(context) {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300], offset: Offset.zero, blurRadius: 20)
          ],
        ),
        child: Row(children: [
          Container(
            alignment: Alignment.bottomCenter,
            width: (MediaQuery.of(context).size.width - 80) / 2,
            height: 140,
            child: Image.asset(
              "assets/doctor.png",
            ),
          ),
          SizedBox(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            height: 150,
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Symptoms \nChecker',
                  style: textStyle(24, FontWeight.w800, Colors.black)),
              const SizedBox(height: 16),
              Text('Based on common \symptoms',
                  style: textStyle(16, FontWeight.w800, Colors.grey[600]))
            ]),
          ),
        ]));
  }

  TextStyle textStyle(double size, FontWeight fontWeight, Color colorName) =>
      TextStyle(
        fontFamily: 'QuickSand',
        color: colorName,
        fontSize: size,
        fontWeight: fontWeight,
      );
}