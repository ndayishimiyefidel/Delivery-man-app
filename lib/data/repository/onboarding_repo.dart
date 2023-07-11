import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/data/model/response/onboarding_model.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';

class OnBoardingRepo {

  Future<Response> getOnBoardingList() async {
    try {
      List<OnBoardingModel> onBoardingList = [
        OnBoardingModel(Images.onboard_1, 'Home Delivery'.tr, 'We delivery whatever on your doorstep'.tr),
        OnBoardingModel(Images.onboard_2, 'Physical Location'.tr, 'We found on physical location'.tr),
        OnBoardingModel(Images.onboard_3, 'Our customers/Clients is King'.tr, 'Enjoy the best delivery that we offer for you'.tr),
        // OnBoardingModel(Images.intro1, 'on_boarding_1_title'.tr, 'on_boarding_1_description'.tr),
        // OnBoardingModel(Images.intro2, 'on_boarding_2_title'.tr, 'on_boarding_2_description'.tr),
        // OnBoardingModel(Images.intro3, 'on_boarding_3_title'.tr, 'on_boarding_3_description'.tr),
      ];

      Response response = Response(body: onBoardingList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(statusCode: 404, statusText: 'Onboarding data not found');
    }
  }
}
