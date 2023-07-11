import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';

class DeliveryWiseEarnedModel {
  int totalSize;
  String limit;
  String offset;
  List<Orders> orders;

  DeliveryWiseEarnedModel(
      {this.totalSize, this.limit, this.offset, this.orders});

  DeliveryWiseEarnedModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders.add(Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (orders != null) {
      data['orders'] = orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int id;
  int customerId;
  String customerType;
  String paymentStatus;
  String orderStatus;
  String paymentMethod;
  String transactionRef;
  double orderAmount;
  String isPause;
  String cause;
  int shippingAddress;
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
  double deliverymanCharge;
  String expectedDeliveryDate;
  String orderNote;
  int billingAddress;
  String billingAddressData;
  String orderType;
  double extraDiscount;
  String extraDiscountType;


  Seller seller;
  Customer customer;

  Orders(
      {this.id,
        this.customerId,
        this.customerType,
        this.paymentStatus,
        this.orderStatus,
        this.paymentMethod,
        this.transactionRef,
        this.orderAmount,
        this.isPause,
        this.cause,
        this.shippingAddress,
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
        this.deliverymanCharge,
        this.expectedDeliveryDate,
        this.orderNote,
        this.billingAddress,
        this.billingAddressData,
        this.orderType,
        this.extraDiscount,
        this.extraDiscountType,
        this.seller,
        this.customer});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    customerType = json['customer_type'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    paymentMethod = json['payment_method'];
    transactionRef = json['transaction_ref'];
    if(json['order_amount'] != null){
      try{
        orderAmount = json['order_amount'].toDouble();
      }catch(e){
        orderAmount = double.parse(json['order_amount'].toString());
      }
    }

    isPause = json['is_pause'];
    cause = json['cause'];
    shippingAddress = json['shipping_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if(json['discount_amount'] != null){
      try{
        discountAmount = json['discount_amount'].toDouble();
      }catch(e){
        discountAmount = double.parse(json['discount_amount'].toString());
      }
    }

    discountType = json['discount_type'];
    couponCode = json['coupon_code'];
    shippingMethodId = json['shipping_method_id'];
    if(json['shipping_cost'] != null){
      try{
        shippingCost = json['shipping_cost'].toDouble();
      }catch(e){
        shippingCost = double.parse( json['shipping_cost'].toString());
      }
    }

    orderGroupId = json['order_group_id'];
    verificationCode = json['verification_code'];
    sellerId = json['seller_id'];
    sellerIs = json['seller_is'];
    shippingAddressData = json['shipping_address_data'];
    deliveryManId = json['delivery_man_id'];
    if(json['deliveryman_charge'] != null){
      try{
        deliverymanCharge = json['deliveryman_charge'].toDouble();
      }catch(e){
        deliverymanCharge = double.parse(json['deliveryman_charge'].toString());
      }

    }

    expectedDeliveryDate = json['expected_delivery_date'];
    orderNote = json['order_note'];
    billingAddress = json['billing_address'];
    billingAddressData = json['billing_address_data'];
    orderType = json['order_type'];
    extraDiscount = json['extra_discount'].toDouble();
    extraDiscountType = json['extra_discount_type'];
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
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
    data['is_pause'] = isPause;
    data['cause'] = cause;
    data['shipping_address'] = shippingAddress;
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
    data['deliveryman_charge'] = deliverymanCharge;
    data['expected_delivery_date'] = expectedDeliveryDate;
    data['order_note'] = orderNote;
    data['billing_address'] = billingAddress;
    data['billing_address_data'] = billingAddressData;
    data['order_type'] = orderType;
    data['extra_discount'] = extraDiscount;
    data['extra_discount_type'] = extraDiscountType;

    if (seller != null) {
      data['seller'] = seller.toJson();
    }
    if (customer != null) {
      data['customer'] = customer.toJson();
    }
    return data;
  }
}

class Seller {
  int id;
  String fName;
  String lName;
  String phone;
  String image;
  String email;
  Shop shop;


  Seller(
      {this.id,
        this.fName,
        this.lName,
        this.phone,
        this.image,
        this.email,
        this.shop
        });

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    image = json['image'];
    email = json['email'];
    shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['image'] = image;
    data['email'] = email;
    if (shop != null) {
      data['shop'] = shop.toJson();
    }

    return data;
  }
}


