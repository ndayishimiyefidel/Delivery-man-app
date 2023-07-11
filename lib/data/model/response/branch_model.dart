class Branch {
  final String id;
  final String name;

  Branch({this.id,this.name});

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'].toString(),
      name: json['name'],
    );
  }
}