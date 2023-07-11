import 'package:sixvalley_delivery_boy/data/model/response/language_model.dart';
import 'images.dart';

class AppConstants {
  static const String companyName = 'IPOSITA';
  static const String appName = 'IMMS V.3';
  static const String polylineMapKey = 'MAP_KEY';
  static const String baseUri = 'https://bmg.nigoote.com';
  //driver routes
  // static const String baseUri = 'http://192.168.1.69';
  // static const String baseUri = 'http://127.0.0.1:8000';
  // static const String baseUri = 'http://10.0.2.2:8000';
  static const String driverLoginUri ='/api/driver/login';
  static const String checkLoginStatusUri ='/api/driver/login-status';
  static const String driverLogoutUri ='/api/driver/driver-logout';
  static const String getAssignedDriverMailUri ='/api/driver/driver-mails/';
  static const String getAssignedDriverNationalMailUri ='/api/driver/driver-international-mails/';
  static const String getDriverApprovedInternationalMailUri ='/api/driver/driver-approved-international-mails/';
  static const String getDriverRouteUri ='/api/driver/get-driver-route/';
  static const String getTotalMailUri ='/api/driver/get-total-mails/';
  static const String getNationalMailUri ='/api/driver/get-national-mails/';
  static const String getInternationalMailUri ='/api/driver/get-international-mails/';
  static const String countHomeDeliveryMailUri ='/api/driver/count-home-delivery-mails/';
  static const String getDeliveredMailUri ='/api/driver/get-delivered-mails/';
  static const String getPendingMailUri ='/api/driver/get-pending-mails/';
  static const String getRecentAssignedUri ='/api/driver/get-recent-mails/';
  static const String getCarInfoUri ='/api/driver/getDriverVehicle/';
  static const String saveRouteUri ='/api/driver/save-route';
  static const String saveMilleageUri ='/api/driver/save-milleage';
  static const String getMilleageUri ='/api/driver/get-driver-milleage/';
  static const String getUpdateUri ='/api/driver/driver-mail-status-update/';
  static const String driverUpdateRouteUri ='/api/driver/update-driver-route/';
  static const String driverHomeRequestUri ='/api/driver/driver-get-home-request/';
  static const String driverDeliverMailUri ='/api/driver/driver-deliver-mail/';





  ///customer rest api

  static const String customerRegisterUri ='/api/customer/register';
  static const String customerLoginUri ='/api/customer/login';
  static const String customerBranchUri ='/api/customer/get-branches';
  static const String customerGetAvBranchUri ='/api/customer/get-branch-pox-box/';
  static const String customerHisPoxBoxUri ='/api/customer/get-pox-box/';
  static const String customerPaymentsUri ='/api/customer/get-payment-history/';
  static const String customerPobUri ='/api/customer/get-pob-by-id/';

  //get-pob-by-id
  static const String customerPhysicalPobUri ='/api/customer/get-customer-physical-pob/';
  static const String customerVirtualPobUri ='/api/customer/get-customer-virtual-pob/';
  static const String customerPoxBoxApplicationUri ='/api/customer/pox-box-application';
  static const String customerRenewApplicationUri ='/api/customer/pox-box-existing';
  static const String customerVirtualApplicationUri ='/api/customer/pox-box-virtual';
  static const String customerNationalUri ='/api/customer/get-customer-national/';
  static const String customerInternationalUri ='/api/customer/get-customer-inbox/';
  static const String customerDeliveryUri ='/api/customer/get-customer-request/';
  static const String getCustomerMailUri ='/api/customer/get-total-mails/';
  static const String getCustomerAddressUri ='/api/customer/get-customer-address/';
  static const String customerAddressUri ='/api/customer/customer-virtual-address/';
  static const String customerHomeLocationUri ='/api/customer/update-home-location/';
  static const String customerOfficeLocationUri ='/api/customer/update-office-location/';
  static const String customerGetBoxInfoUri ='/api/customer/customer-get-address/';
  static const String saveHomeDeliveryUri ='/api/customer/save-home-delivery';
  static const String savePaymentUri ='/api/customer/save-payment';
  //save-payment

  ///rest api
  static const String profileUri = '/api/v2/delivery-man/info';
  // static const String configUri = '/api/v1/config';
  static const String loginUri = '/api/v2/delivery-man/auth/login';
  static const String notificationUri = '/api/v2/delivery-man/ notifications';
  static const String currentOrderUri = '/api/v2/delivery-man/current-orders';
  static const String orderDetailsUri = '/api/v2/delivery-man/order-details?order_id=';
  static const String allOrderHistoryUri = '/api/v2/delivery-man/all-orders';
  static const String recordLocationUri = '/api/v2/delivery-man/record-location-data';
  static const String updateOrderStatusUri = '/api/v2/delivery-man/update-order-status';
  static const String rescheduleOrderStatusUri = '/api/v2/delivery-man/update-expected-delivery';
  static const String pauseAndResumeOrderStatusUri = '/api/v2/delivery-man/order-update-is-pause';
  static const String updatePaymentStatusUri = '/api/v2/delivery-man/update-payment-status';
  static const String tokenUri = '/api/v2/delivery-man/update-fcm-token';
  static const String searchConversationListUri = '/api/v2/delivery-man/update-fcm-token';
  static const String statusOnOffUri = '/api/v2/delivery-man/is-online';
  static const String withdrawRequestUri = '/api/v2/delivery-man/withdraw-request';
  static const String walletInfoUri = '/api/v2/delivery-man/wallet';
  static const String orderCountUri = '/api/v2/delivery-man/order-count';
  static const String deliveryWiseEarnedUri = '/api/v2/delivery-man/delivery-wise-earned';
  static const String orderListFilterByDate = '/api/v2/delivery-man/order-list-by-date';
  static const String orderSearchUri = '/api/v2/delivery-man/search';
  static const String profileUpdateUri = '/api/v2/delivery-man/update-info';
  static const String chatListUri = '/api/v2/delivery-man/messages/list/';
  static const String messageListUri = '/api/v2/delivery-man/messages/get-message/';
  static const String sendMessageUri = '/api/v2/delivery-man/messages/send-message/';
  static const String withdrawListUri = '/api/v2/delivery-man/withdraw-list-by-approved';
  static const String emergencyContactList = '/api/v2/delivery-man/emergency-contact-list';
  static const String depositedList = '/api/v2/delivery-man/collected_cash_history';
  static const String forgetPassword = '/api/v2/delivery-man/auth/forgot-password';
  static const String verifyOtp = '/api/v2/delivery-man/auth/verify-otp';
  static const String resetPassword = '/api/v2/delivery-man/auth/reset-password';
  static const String reviewListUri = '/api/v2/delivery-man/review-list';
  static const String updateBankInfo = '/api/v2/delivery-man/bank-info';
  static const String distanceApi = '/api/v2/delivery-man/distance-api';
  static const String chatSearch = '/api/v2/delivery-man/messages/search/';
  static const String addToSavedReviewList = '/api/v2/delivery-man/save-review';


  // Shared Key
  static const String theme = 'theme';
  static const String token = 'token';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static const String cartList = 'cart_list';
  static const String userPassword = 'user_password';
  static const String userEmail = 'user_email';
  static const String currency = 'currency';
  static const String topic = 'six_valley_delivery';
  static const String intro = '6valley_delivery';
  static const String localizationKey = 'X-localization';
  static const String notificationCount = 'count';
  static const String notificationSound = 'sound';


  static List<LanguageModel> languages = [

    LanguageModel(imageUrl: Images.unitedKindom, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: Images.arabic, languageName: 'Arabic', countryCode: 'SA', languageCode: 'ar'),
  ];
}
