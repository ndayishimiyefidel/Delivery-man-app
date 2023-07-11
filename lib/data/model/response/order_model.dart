
class OrderModel {
  int id;
  int customerId;
  String customerType;
  String paymentStatus;
  String orderStatus;
  String paymentMethod;
  String transactionRef;
  double orderAmount;
  String createdAt;
  String updatedAt;
  double discountAmount;
  String discountType;
  String couponCode;
  int shippingMethodId;
  double shippingCost;
  String orderGroupId;
  String verificationCode;
  int sellerId;
  String sellerIs;
  String shippingAddressData;
  int deliveryManId;
  Customer customer;
  String orderNote;
  String billingAddress;
  SellerInfo sellerInfo;
  String expectedDate;
  double deliveryManCharge;
  String isPause;
  ShippingAddress shippingAddress;

  OrderModel(
      {this.id,
        this.customerId,
        this.customerType,
        this.paymentStatus,
        this.orderStatus,
        this.paymentMethod,
        this.transactionRef,
        this.orderAmount,
        this.createdAt,
        this.updatedAt,
        this.discountAmount,
        this.discountType,
        this.couponCode,
        this.shippingMethodId,
        this.shippingCost,
        this.orderGroupId,
        this.verificationCode,
        this.sellerId,
        this.sellerIs,
        this.shippingAddressData,
        this.deliveryManId,
        this.customer,
        this.orderNote,
        this.billingAddress,
        this.sellerInfo,
        this.expectedDate,
        this.deliveryManCharge,
        this.isPause,
        this.shippingAddress,
      });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    customerType = json['customer_type'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    paymentMethod = json['payment_method'];
    transactionRef = json['transaction_ref'];
    orderAmount = json['order_amount'].toDouble();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    discountAmount = json['discount_amount'].toDouble();
    discountType = json['discount_type'];
    couponCode = json['coupon_code'];
    shippingMethodId = json['shipping_method_id'];
    shippingCost = json['shipping_cost'].toDouble();
    orderGroupId = json['order_group_id'];
    verificationCode = json['verification_code'];
    sellerId = json['seller_id'];
    sellerIs = json['seller_is'];
    shippingAddressData = json['shipping_address_data'];
    deliveryManId = json['delivery_man_id'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;

    orderNote = json['order_note'];
    billingAddress = json['billing_address_data'];
    sellerInfo = json['seller'] != null ? SellerInfo.fromJson(json['seller']) : null;
    if(json['expected_delivery_date'] != null){
      expectedDate = json['expected_delivery_date'];
    }

    if(json['deliveryman_charge'] != null){
      try{
        deliveryManCharge = json['deliveryman_charge'].toDouble();
      }catch(e){
        deliveryManCharge = double.parse(json['deliveryman_charge'].toString());
      }

    }
    if(json['is_pause'] != null){
      isPause = json['is_pause'];
    }

    shippingAddress = json['shipping_address'] != null
        ? ShippingAddress.fromJson(json['shipping_address'])
        : null;


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['customer_type'] = customerType;
    data['payment_status'] = paymentStatus;
    data['order_status'] = orderStatus;
    data['payment_method'] = paymentMethod;
    data['transaction_ref'] = transactionRef;
    data['order_amount'] = orderAmount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['discount_amount'] = discountAmount;
    data['discount_type'] = discountType;
    data['coupon_code'] = couponCode;
    data['shipping_method_id'] = shippingMethodId;
    data['shipping_cost'] = shippingCost;
    data['order_group_id'] = orderGroupId;
    data['verification_code'] = verificationCode;
    data['seller_id'] = sellerId;
    data['seller_is'] = sellerIs;
    data['shipping_address_data'] = shippingAddressData;
    data['delivery_man_id'] = deliveryManId;
    if (customer != null) {
      data['customer'] = customer.toJson();
    }
    data['order_note'] = orderNote;
    data['billing_address_data'] = billingAddress;
    data['expected_delivery_date'] = expectedDate;
    data['deliveryman_charge'] = deliveryManCharge;
    data['is_pause'] = isPause;
    if (sellerInfo != null) {
      data['seller'] = sellerInfo.toJson();
    }
    if (shippingAddress != null) {
      data['shipping_address'] = shippingAddress.toJson();
    }
    return data;
  }
}

class ShippingAddress {
  int id;
  int customerId;
  String contactPersonName;
  String addressType;
  String address;
  String city;
  String zip;
  String phone;
  String createdAt;
  String updatedAt;
  String state;
  String country;
  String latitude;
  String longitude;


  ShippingAddress(
      {this.id,
        this.customerId,
        this.contactPersonName,
        this.addressType,
        this.address,
        this.city,
        this.zip,
        this.phone,
        this.createdAt,
        this.updatedAt,
        this.state,
        this.country,
        this.latitude,
        this.longitude
      });

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    contactPersonName = json['contact_person_name'];
    addressType = json['address_type'];
    if(json['address']!=null){
      address = json['address'];
    }
    city = json['city'];
    zip = json['zip'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['contact_person_name'] = contactPersonName;
    data['address_type'] = addressType;
    data['address'] = address;
    data['city'] = city;
    data['zip'] = zip;
    data['phone'] = phone;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['state'] = state;
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }

  @override
  String toString() {
    return 'ShippingAddress{contactPersonName: $contactPersonName, address: $address, city: $city, zip: $zip, phone: $phone, country: $country}';
  }
}

class Customer {
  int id;
  String name;
  String fName;
  String lName;
  String phone;
  String image;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String streetAddress;
  String country;
  String city;
  String zip;
  String houseNo;
  String apartmentNo;
  String cmFirebaseToken;
  int isActive;
  String loginMedium;
  String socialId;
  int isPhoneVerified;
  String temporaryToken;
  String paymentCardLastFour;
  String paymentCardBrand;
  String paymentCardFawryToken;
  int isEmailVerified;

  Customer(
      {this.id,
        this.name,
        this.fName,
        this.lName,
        this.phone,
        this.image,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.streetAddress,
        this.country,
        this.city,
        this.zip,
        this.houseNo,
        this.apartmentNo,
        this.cmFirebaseToken,
        this.isActive,
        this.loginMedium,
        this.socialId,
        this.isPhoneVerified,
        this.temporaryToken,
        this.paymentCardLastFour,
        this.paymentCardBrand,
        this.paymentCardFawryToken,
        this.isEmailVerified});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    if(json['image'] != null){
      image = json['image'];
    }
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    streetAddress = json['street_address'];
    country = json['country'];
    city = json['city'];
    zip = json['zip'];
    houseNo = json['house_no'];
    apartmentNo = json['apartment_no'];
    cmFirebaseToken = json['cm_firebase_token'];
    isActive = json['is_active'];
    loginMedium = json['login_medium'];
    socialId = json['social_id'];
    isPhoneVerified = json['is_phone_verified'];
    temporaryToken = json['temporary_token'];
    paymentCardLastFour = json['payment_card_last_four'];
    paymentCardBrand = json['payment_card_brand'];
    paymentCardFawryToken = json['payment_card_fawry_token'];
    isEmailVerified = json['is_email_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['image'] = image;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['street_address'] = streetAddress;
    data['country'] = country;
    data['city'] = city;
    data['zip'] = zip;
    data['house_no'] = houseNo;
    data['apartment_no'] = apartmentNo;
    data['cm_firebase_token'] = cmFirebaseToken;
    data['is_active'] = isActive;
    data['login_medium'] = loginMedium;
    data['social_id'] = socialId;
    data['is_phone_verified'] = isPhoneVerified;
    data['temporary_token'] = temporaryToken;
    data['payment_card_last_four'] = paymentCardLastFour;
    data['payment_card_brand'] = paymentCardBrand;
    data['payment_card_fawry_token'] = paymentCardFawryToken;
    data['is_email_verified'] = isEmailVerified;
    return data;
  }
}


class SellerInfo {
  int id;
  String phone;
  String email;
  Shop shop;


  SellerInfo(
      {this.id,
        this.shop,
      this.phone,
      this.email});

  SellerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    email = json['email'];
    shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['email'] = email;
    if (shop != null) {
      data['shop'] = shop.toJson();
    }
    return data;
  }
}

class Shop {
  int id;
  int sellerId;
  String name;
  String image;
  String address;


  Shop(
      {this.id,
        this.sellerId,
        this.name,
        this.image,
        this.address,
      });

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = int.parse(json['seller_id'].toString());
    name = json['name'];
    image = json['image'];
    address = json['address'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['seller_id'] = sellerId;
    data['name'] = name;
    data['image'] = image;
    data['address'] = address;
    return data;
  }
}