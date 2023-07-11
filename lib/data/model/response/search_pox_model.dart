class SearchPox {
  final String id;
  final String name;
  final String pob;

  SearchPox({this.id,this.name,this.pob});
  factory SearchPox.fromJson(Map<String, dynamic> json) {
    return SearchPox(
      id: json['id'].toString(),
      name: json['name'],
      pob:json['pob'].toString(),
    );
  }
}