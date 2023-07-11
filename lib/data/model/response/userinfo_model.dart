import 'dart:convert';

class UserInfoModel {
  int id;
  String fName;
  String lName;
  String phone;
  String email;
  String image;
  String identityNumber;
  String identityType;
  List<dynamic> identityImage;
  int isActive;
  String createdAt;
  String updatedAt;
  double withdrawableBalance;
  double currentBalance;
  double cashInHand;
  double pendingWithdraw;
  double totalWithdraw;
  double totalEarn;
  int completedDelivery;
  int totalDelivery;
  int pendingDelivery;
  double totalDeposit;
  String countryCode;
  String address;
  String bankName;
  String branch;
  String accountNo;
  String holderName;

  UserInfoModel(
      {this.id,
        this.fName,
        this.lName,
        this.phone,
        this.email,
        this.image,
        this.identityNumber,
        this.identityType,
        this.identityImage,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.withdrawableBalance,
        this.currentBalance,
        this.cashInHand,
        this.pendingWithdraw,
        this.totalWithdraw,
        this.totalEarn,
        this.completedDelivery,
        this.totalDelivery,
        this.pendingDelivery,
        this.totalDeposit,
        this.address,
        this.countryCode,
        this.bankName,
        this.branch,
        this.accountNo,
        this.holderName,
      });

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    isActive = int.parse(json['is_online'].toString());
    identityNumber = json['identity_number'];
    identityType = json['identity_type'];
    identityImage = jsonDecode(json['identity_image']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if(json['withdrawable_balance'] != null){
      try{
        withdrawableBalance = json['withdrawable_balance'].toDouble();
      }catch(e){
        withdrawableBalance = double.parse(json['withdrawable_balance']);
      }

    }else{
      withdrawableBalance = 0;
    }
    if(json['current_balance'] != null){
      try{
        currentBalance = json['current_balance'].toDouble();
      }catch(e){
        currentBalance = double.parse(json['current_balance']);
      }
    }else{
      currentBalance = 0;
    }
    if(json['cash_in_hand'] != null){
      try{
        cashInHand = json['cash_in_hand'].toDouble();
      }catch(e){
        cashInHand = double.parse(json['cash_in_hand']);
      }
    }else{
      cashInHand = 0;
    }
    if(json['pending_withdraw'] != null){
      try{
        pendingWithdraw = json['pending_withdraw'].toDouble();
      }catch(e){
        pendingWithdraw = double.parse(json['pending_withdraw']);
      }
    }else{
      pendingWithdraw = 0;
    }
    if(json['total_withdraw'] != null){
      try{
        totalWithdraw = json['total_withdraw'].toDouble();
      }catch(e){
        totalWithdraw = double.parse(json['total_withdraw']);
      }
    }else{
      totalWithdraw = 0;
    }

    if(json['total_earn'] != null){
      totalEarn = json['total_earn'].toDouble();
    }else{
      totalEarn = 0;
    }
    if(json['completed_delivery'] != null){
      completedDelivery = json['completed_delivery'];
    }else{
      completedDelivery = 0;
    }
    if(json['total_delivery'] != null){
      totalDelivery = json['total_delivery'];
    }else{
      totalDelivery = 0;
    }
    if(json['pending_delivery'] != null){
      pendingDelivery = json['pending_delivery'];
    }else{
      pendingDelivery = 0;
    }
    if(json['total_deposit'] != null){
      try{
        totalDeposit = json['total_deposit'].toDouble();
      }catch(e){
        totalDeposit = double.parse(json['total_deposit']);
      }
    }else{
      totalDeposit = 0;
    }
    countryCode = json['country_code'];
    if(json['address'] != null){
      address = json['address'];
    }else{
      address = '';
    }

    if(json['bank_name'] != null){
      bankName = json['bank_name'];
    }
    if(json['branch'] != null){
      branch = json['branch'];
    }

    if(json['account_no'] != null){
      accountNo = json['account_no'];
    }
    if(json['holder_name'] != null){
      holderName = json['holder_name'];
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['email'] = email;
    data['image'] = image;
    data['is_online'] = isActive;
    data['identity_number'] = identityNumber;
    data['identity_type'] = identityType;
    data['identity_image'] = identityImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['withdrawable_balance'] = withdrawableBalance;
    data['current_balance'] = currentBalance;
    data['cash_in_hand'] = cashInHand;
    data['pending_withdraw'] = pendingWithdraw;
    data['total_withdraw'] = totalWithdraw;
    data['total_earn'] = totalEarn;
    data['completed_delivery'] = completedDelivery;
    data['pending_delivery'] = pendingDelivery;
    data['country_code'] = countryCode;
    data['total_delivery'] = address;
    data['address'] = totalDelivery;
    data['bank_name'] = bankName;
    data['branch'] = branch;
    data['account_no'] = accountNo;
    data['holder_name'] = holderName;
    return data;
  }
}
