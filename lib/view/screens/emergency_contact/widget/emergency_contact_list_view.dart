import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/view/base/no_data_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/emergency_contact/widget/emergency_contact_card.dart';

class EmergencyContactListView extends StatelessWidget {
  final ProfileController profileController;
   const EmergencyContactListView({Key key, this.profileController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [

      profileController.emergencyContactList.isNotEmpty?
      ListView.builder(
          itemCount: profileController.emergencyContactList.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index){
            return EmergencyContactCard(contactList: profileController.emergencyContactList[index],);
          }):const NoDataScreen()
    ],);
  }
}

