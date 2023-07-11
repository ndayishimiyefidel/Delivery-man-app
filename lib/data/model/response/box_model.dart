class Box {
  final String id;
  final String name;
  final int pob;
  final String email,phone;
  final String size,status,type,date;
  final int amount,cotion,year;


  Box({this.year,this.date,this.type,this.pob, this.email, this.phone, this.id,this.name,this.size,this.amount,this.status,this.cotion});

  factory Box.fromJson(Map<String, dynamic> json) {
    return Box(
      name: json['name'],
      id: json['id'].toString(),
      pob: json['pob'],
      email: json['email'],
      phone: json['phone'],
      size: json['size'],
      cotion: json['cotion'],
      amount: json['amount'],
      status: json['status'],
      type: json['pob_type'],
      date: json['date'],
      year:json['year'],
    );
  }
}

class Payments{
  final int amount,year,id;
  final String date;

  Payments({this.amount, this.year,this.id,this.date});
  factory Payments.fromJson(Map<String, dynamic> json) {
    return Payments(
      id: json['id'],
      amount: json['amount'],
      date: json['created_at'],
      year:json['year'],
    );
  }


}