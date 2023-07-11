
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:sixvalley_delivery_boy/controller/auth_controller.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/data/model/response/userinfo_model.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_button.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_snackbar.dart';
import 'package:sixvalley_delivery_boy/view/screens/profile/widget/account_info.dart';
import 'package:sixvalley_delivery_boy/view/screens/profile/widget/general_info.dart';
import 'package:sixvalley_delivery_boy/view/screens/profile/widget/profile_header.dart';


class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key key}) : super(key: key);

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen>  with TickerProviderStateMixin {




  _updateUserAccount() async {
    String _firstName = Get.find<ProfileController>().firstNameController.text.trim();
    String _lastName =  Get.find<ProfileController>().firstNameController.text.trim();
    String _password = Get.find<ProfileController>().passwordController.text.trim();
    String _confirmPassword = Get.find<ProfileController>().confirmPasswordController.text.trim();

    if(Get.find<ProfileController>().profileModel.fName ==  Get.find<ProfileController>().firstNameController.text
        && Get.find<ProfileController>().profileModel.lName ==  Get.find<ProfileController>().lastNameController.text
        && Get.find<ProfileController>().profileModel.address ==  Get.find<ProfileController>().addressController.text &&
        Get.find().file == null
        &&  Get.find<ProfileController>().passwordController.text.isEmpty &&  Get.find<ProfileController>().confirmPasswordController.text.isEmpty) {
      showCustomSnackBar('change_something_to_update'.tr);
    }
    else {
      UserInfoModel updateUserInfoModel = Get.find<ProfileController>().profileModel;
      updateUserInfoModel.fName =  Get.find<ProfileController>().firstNameController.text ?? "";
      updateUserInfoModel.lName =  Get.find<ProfileController>().lastNameController.text ?? "";
      updateUserInfoModel.address =  Get.find<ProfileController>().addressController.text ?? "";
      String _password =  Get.find<ProfileController>().passwordController.text ?? '';
      Get.find().updateUserInfo(updateUserInfoModel, _password);

    }
  }

  TabController _tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);

    _tabController?.addListener((){
      switch (_tabController.index){
        case 0:
          Get.find().setIndexForTabBar(1, isNotify: true);
          break;
        case 1:
          Get.find().setIndexForTabBar(0, isNotify: true);
          break;

      }
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomRiderAppBar(title: 'edit_profile'.tr,isSwitch: false, isBack: true),
      body: GetBuilder<ProfileController>(
        builder: (profile) {

          if(profile.firstNameController.text.isEmpty ||  profile.lastNameController.text.isEmpty) {
            // profile.firstNameController.text = profile.profileModel.fName;
            // profile.lastNameController.text = profile.profileModel.lName;
            // profile.addressController.text = profile.profileModel.address;
          }
          return Column(
            children: [

              // const ProfileHeader(),

              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).canvasColor,
                  child: TabBar(
                    padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                    controller: _tabController,
                    labelColor:Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor,
                    unselectedLabelColor: Theme.of(context).hintColor,
                    indicatorColor: Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor,
                    indicatorWeight: 1,
                    unselectedLabelStyle: rubikRegular.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      fontWeight: FontWeight.w400,
                    ),
                    labelStyle: rubikRegular.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      fontWeight: FontWeight.w700,
                    ),
                    tabs: [
                      Tab(text: 'general_info'.tr),
                      Tab(text: 'login_info'.tr),
                    ],
                  ),
                ),
              ),


              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeDefault),
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      GeneralInfo(),
                      AccountInfo(),


                    ],
                  ),
                ),
              ),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeSmall),
                  child: !profile.isLoading
                      ? CustomButton(onTap: _updateUserAccount,
                      btnTxt: 'update_profile'.tr)
                      : Center(child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
