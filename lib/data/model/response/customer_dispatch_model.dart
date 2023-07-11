class CustomerDispatchModel {
  int id;
  String senderName;
  String senderPhone;
  String senderPOBox;
  String mailsNumber;
  int weight;
  int price;
  String dispatchNumber;
  String securityCode;
  int postAgent;
  int status;
  String sendDate;
  String deliveryDate;
  int customerId;
  String createdAt;
  String updatedAt;

  CustomerDispatchModel(
      this.id,
      this.senderName,
      this.senderPhone,
      this.senderPOBox,
      this.mailsNumber,
      this.weight,
      this.price,
      this.dispatchNumber,
      this.securityCode,
      this.postAgent,
      this.status,
      this.sendDate,
      this.deliveryDate,
      this.customerId,
      this.createdAt,
      this.updatedAt);
  CustomerDispatchModel.fromJson(Map json){
    id=json['id'];
    senderName=json['senderName'];
    senderPhone=json['senderPhone'];
    senderPOBox=json['senderPOxBox'];
    mailsNumber=json['mailsNumber'];
    weight=json['weight'];
    price=json['price'];
    dispatchNumber=json['dispatchNumber'];
    securityCode=json['securityCode'];
    postAgent=json['postAgent'];
    status=json['status'];
    customerId=json['customer_id'];
    sendDate=json['sendDate'];
    deliveryDate=json['deliveryDate'];

  }


}