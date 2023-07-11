class MessageModel {
  int totalSize;
  String limit;
  String offset;
  List<Message> message;

  MessageModel({this.totalSize, this.limit, this.offset, this.message});

  MessageModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message.add(Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (message != null) {
      data['message'] = message.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  int id;
  String message;
  int sentByCustomer;
  int sentBySeller;
  int sentByAdmin;
  int seenByDeliveryMan;
  String createdAt;
  Customer customer;
  SellerInfo sellerInfo;

  Message(
      {this.id,
        this.message,
        this.sentByCustomer,
        this.sentBySeller,
        this.sentByAdmin,
        this.seenByDeliveryMan,
        this.createdAt,
        this.customer,
        this.sellerInfo});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    if(json['sent_by_customer'] != null){
      sentByCustomer = int.parse(json['sent_by_customer'].toString());
    }
    if(json['sent_by_seller'] != null){
      sentBySeller = int.parse(json['sent_by_seller'].toString());
    }
    if(json['sent_by_admin'] != null){
      sentByAdmin = int.parse(json['sent_by_admin'].toString());
    }
    if(json['seen_by_delivery_man'] != null){
      seenByDeliveryMan = int.parse(json['seen_by_delivery_man'].toString());
    }

    createdAt = json['created_at'];
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    sellerInfo = json['seller_info'] != null ? SellerInfo.fromJson(json['seller_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['sent_by_customer'] = sentByCustomer;
    data['sent_by_seller'] = sentBySeller;
    data['sent_by_admin'] = sentByAdmin;
    data['seen_by_delivery_man'] = seenByDeliveryMan;
    data['created_at'] = createdAt;
    if (customer != null) {
      data['customer'] = customer.toJson();
    }
    if (sellerInfo != null) {
      data['seller_info'] = sellerInfo.toJson();
    }
    return data;
  }
}

class Customer {
  int id;
  String fName;
  String lName;
  String phone;
  String image;
  String email;


  Customer(
      {this.id,
        this.fName,
        this.lName,
        this.phone,
        this.image,
        this.email,
       });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    image = json['image'];
    email = json['email'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['image'] = image;
    data['email'] = email;

    return data;
  }
}

class SellerInfo {
  List<Shops> shops;

  SellerInfo(
      {this.shops});

  SellerInfo.fromJson(Map<String, dynamic> json) {
    if (json['shops'] != null) {
      shops = <Shops>[];
      json['shops'].forEach((v) {
        shops.add(Shops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shops != null) {
      data['shops'] = shops.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shops {
  int id;
  int sellerId;
  String name;
  String image;


  Shops(
      {this.id,
        this.sellerId,
        this.name,
        this.image,
       });

  Shops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if(json['seller_id'] != null){
      sellerId = int.parse(json['seller_id'].toString());
    }
    name = json['name'];
    image = json['image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['seller_id'] = sellerId;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
