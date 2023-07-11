import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/screens/emergency_contact/widget/emergency_contact_list_view.dart';

class EmergencyContactScreen extends StatelessWidget {
  const EmergencyContactScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<ProfileController>().getEmergencyContactList();
    return Scaffold(
      appBar: CustomRiderAppBar(title: 'emergency_contact'.tr, isBack: true),
      body: RefreshIndicator(
        onRefresh: () async{
          Get.find<ProfileController>().getEmergencyContactList();
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: Column(children:  [
              GetBuilder<ProfileController>(
                builder: (profileController) {
                  return EmergencyContactListView(profileController: profileController);
                }
              ),

            ],),)
          ],
        ),
      ),
    );
  }
}
