
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sixvalley_delivery_boy/data/api/api_checker.dart';
import 'package:sixvalley_delivery_boy/data/model/response/emergency_contact_model.dart';
import 'package:sixvalley_delivery_boy/data/model/response/review_model.dart';
import 'package:sixvalley_delivery_boy/data/model/response/userinfo_model.dart';
import 'package:sixvalley_delivery_boy/data/repository/profile_repo.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_snackbar.dart';

class ProfileController extends GetxController implements GetxService {
  final ProfileRepo profileRepo;
  ProfileController({@required this.profileRepo});



  UserInfoModel _profileModel;
  UserInfoModel get profileModel => _profileModel;
  String _profileImage;
  String get profileImage => _profileImage;
  File file;
  final picker = ImagePicker();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isForget = false;
  bool get isForget => _isForget;
  bool _isVerify = false;
  bool get isVerify => _isVerify;

  final List<String> _reviewTypeList = [ 'regular', 'saved'];
  List<String> get reviewTypeList => _reviewTypeList;
   String _selectedReviewType = 'regular';
  String get selectedReviewType=>_selectedReviewType;

  List<ContactList> _emergencyContactList =[];
  List<ContactList> get emergencyContactList => _emergencyContactList;

  bool _isEnableVerificationCode = false;
  bool get isEnableVerificationCode => _isEnableVerificationCode;
  String _verificationCode = '';
  String get verificationCode => _verificationCode;
  bool _isPhoneNumberVerificationButtonLoading = false;
  bool get isPhoneNumberVerificationButtonLoading => _isPhoneNumberVerificationButtonLoading;
  bool _isUpdate = false;
  bool get isUpdate => _isUpdate;


  final FocusNode fNameFocus = FocusNode();
  final FocusNode lNameFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  ReviewModel _reviewModel;
  ReviewModel get reviewModel => _reviewModel;
  List<Review> _reviewList = [];
  List<Review> get reviewList => _reviewList;


  set setSelectedReviewType(String type) {
    _selectedReviewType = type;
  }



  // void choose() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500, maxWidth: 500);
  //     if (pickedFile != null) {
  //       file = File(pickedFile.path);
  //     }
  //     update();
  // }

  Future<void> getProfile() async {
    Response response = await profileRepo.getProfileInfo();
    if (response.statusCode == 200) {
      _profileModel = UserInfoModel.fromJson(response.body);
      _profileImage = _profileModel.image;

    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


  Future<void> getReviewList(int offset, {bool reload = true}) async {
    if(reload){
      _reviewList = [];
    }
    Response response = await profileRepo.getReviewList(offset, selectedReviewType == 'regular'? 0 : 1);
    if (response.statusCode == 200) {
      if(offset == 1){
        _reviewModel = ReviewModel.fromJson(response.body);
        _reviewList = ReviewModel.fromJson(response.body).review;
      }else{
        _reviewModel.totalSize = ReviewModel.fromJson(response.body).totalSize;
        _reviewModel.offset = ReviewModel.fromJson(response.body).offset;
        _reviewModel.review.addAll(ReviewModel.fromJson(response.body).review);
      }

    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }



  Future <void> profileStatusChange(BuildContext context, int status) async {
    Response _response = await profileRepo.profileStatusOnnOff(status);
    if (_response.statusCode == 200) {
      Get.back();
      getProfile();
    } else {
      ApiChecker.checkApi(_response);
    }
    update();
  }

  Future<void> getEmergencyContactList() async {
    Response response = await profileRepo.getEmergencyContactList();
    if (response.statusCode == 200) {
      _emergencyContactList = [];
      _emergencyContactList = EmergencyContactModel.fromJson(response.body).contactList;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future <Response> forgetPassword(String countryCode ,String phone) async {
    _isForget = true;
    update();
    Response _response = await profileRepo.forgetPassword(countryCode, phone);
    if (_response.statusCode == 200) {
     showCustomSnackBar('otp_send_successfully'.tr, isError: false);
    } else {
      ApiChecker.checkApi(_response);
    }
    _isForget = false;
    update();
    return _response;
  }

  Future <Response> verifyOtp (String otp ,String phone) async {
    _isVerify = true;
    update();
    _isPhoneNumberVerificationButtonLoading = true;
    Response _response = await profileRepo.verifyOtp(otp, phone);
    if (_response.statusCode == 200) {

      showCustomSnackBar('otp_verified_successfully'.tr, isError: false);
    } else {
      ApiChecker.checkApi(_response);
    }
    _isPhoneNumberVerificationButtonLoading = false;
    _isVerify = true;
    update();
    return _response;
  }

  Future <Response> resetPassword (String phone, String password ,String confirmPassword) async {
    _isLoading = true;
    update();
    Response _response = await profileRepo.resetPassword(phone, password, confirmPassword);
    if (_response.statusCode == 200) {
      showCustomSnackBar('password_reset_successfully'.tr, isError: false);

    } else {
      ApiChecker.checkApi(_response);
    }
    _isLoading = false;
    update();
    return _response;
  }


  updateVerificationCode(String query) {
    if (query.length == 4) {
      _isEnableVerificationCode = true;
    } else {
      _isEnableVerificationCode = false;
    }
    _verificationCode = query;
    update();
  }

  Future<Response> updateBankInfo(String bankName, String branch, String accountNumber, String holderName) async {
    _isUpdate = true;
    update();
    Response response = await profileRepo.updateBankInfo(bankName: bankName, branch: branch, accountNumber: accountNumber, holderName: holderName);
    if (response.statusCode == 200) {
      Get.find<ProfileController>().getProfile();
      Get.back();
      String message;
      message = response.body['message'];
      showCustomSnackBar(message, isError: false);
    } else {
      ApiChecker.checkApi(response);
    }
    _isUpdate = false;
    update();
    return response;
  }


  Future<Response> savedReview( int reviewId, int isSaved, int index) async {
    Response response = await profileRepo.saveReview(reviewId, isSaved);
    if (response.statusCode == 200) {
      _reviewModel.review[index].isSaved = _reviewModel.review[index].isSaved == 1 ? 0 : 1;
      String message;
      message = response.body['message'];
      showCustomSnackBar(message, isError: false);
    } else {
      ApiChecker.checkApi(response);
    }

    update();
    return response;
  }
}