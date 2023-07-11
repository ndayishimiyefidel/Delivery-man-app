class AirportDispatchModel {
  int id;
  String mailsNumber;
  int grossweight;
  String dispatchNumber;
  String mailType;
  int postAgent;
  int status;
  String createdAt;
  String updatedAt;
  bool isChecked;

 AirportDispatchModel(
      this.id,
      this.mailsNumber,
      this.grossweight,
      this.dispatchNumber,
      this.postAgent,
      this.mailType,
      this.status,
      this.isChecked,
      this.createdAt,
      this.updatedAt);
   AirportDispatchModel.fromJson(Map json){
    id=json['id'];
    mailsNumber=json['mailsNumber'];
    grossweight=json['grossweight'];
    mailType=json['mailtype'];
    dispatchNumber=json['dispatchNumber'];
    postAgent=json['postAgent'];
    status=json['status'];
    createdAt=json['created_at'];

  }


}