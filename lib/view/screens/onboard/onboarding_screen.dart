
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/controller/onboarding_controller.dart';
import 'package:sixvalley_delivery_boy/controller/splash_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/screens/auth/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  double width = Get.width;
  double height = 500;
  var currentPageValue = 0.0;
  SharedPreferences localStorage;

  @override
  void initState() {
    super.initState();
    Get.find<OnBoardingController>().getOnBoardingList();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: GetBuilder<OnBoardingController>(
        builder: (onBoardingController) {
          return onBoardingController.onBoardingList.isNotEmpty ?
          Center(child: SizedBox(width: MediaQuery.of(context).size.width, child: Stack(
            children: [
              Column(children: [

                Expanded(child: PageView.builder(
                  pageSnapping: true,
                  itemCount: onBoardingController.onBoardingList.length,
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeOverLarge, vertical: Dimensions.paddingSizeExtraLarge),
                        child: SizedBox(width: Get.width,height: Get.width/1.5,
                            child: Image.asset(onBoardingController.onBoardingList[index].imageUrl, fit: BoxFit.contain,)),
                      ),

                      Text(onBoardingController.onBoardingList[index].title,
                        style: rubikRegular.copyWith(fontSize: Dimensions.paddingSizeDefault, color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.center,
                      ),


                      Text(onBoardingController.onBoardingList[index].description,
                        style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                        textAlign: TextAlign.center,
                      ),

                    ]);
                  },
                  onPageChanged: (index) {
                    onBoardingController.changeSelectIndex(index);
                  },
                )),

                Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                  children: _pageIndicators(onBoardingController, context)),
                SizedBox(height: context.height * 0.05),




                onBoardingController.selectedIndex != 2 ?
                GestureDetector(onTap: (){
                  Get.find<SplashController>().disableIntro();
                  Get.offAll(const LoginScreen());
                },
                    child: Text('skip'.tr,style: rubikBold.copyWith(color: Theme.of(context).primaryColor.withOpacity(.7)))):

                InkWell(onTap: () async {

                  Get.find<SplashController>().disableIntro();
                  localStorage= await SharedPreferences.getInstance();
                  localStorage.setBool("isCompleted", true);
                  Get.offAll(const LoginScreen());
                  },
                    child: Text('get_started'.tr,style: rubikMedium.copyWith(color: Theme.of(context).primaryColor))),
                 SizedBox(height: Dimensions.skipSpace),


              ]),

              Positioned(bottom: 70,child: Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(width: 100, child: Image.asset(Images.leftBox)),)),
              Positioned(child: Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(width: 100, child: Image.asset(Images.rightBox)),)),
            ],
          ))) : const SizedBox();
        }
      ),
    );
  }

  List<Widget> _pageIndicators(OnBoardingController onBoardingController, BuildContext context) {
    List<Container> _indicators = [];

    for (int i = 0; i < onBoardingController.onBoardingList.length; i++) {
      _indicators.add(
        Container(
          width: i == onBoardingController.selectedIndex? 15 :7,
          height: 7,
          margin:  EdgeInsets.only(right: Dimensions.paddingSizeExtraSmall),
          decoration: BoxDecoration(
            color: i == onBoardingController.selectedIndex ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(.25),
            borderRadius: i == onBoardingController.selectedIndex ? BorderRadius.circular(50) : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return _indicators;
  }
}
