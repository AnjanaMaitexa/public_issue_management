class Workers{
    String? id;
    String? name;
    String? address;

    Workers({this.id, this.name, this.address});

 /*   Workers.fromJson(Map<String, dynamic> json) {
      id = json['_id'];
      name = json['name'];
      address = json['address'];
  }*/
/*

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['address'] = address;
    return data;
  }
*/

    factory Workers.fromJson(Map<String, dynamic> json) {
      return Workers(
        id: json['_id'],
        name: json['name'],
        address: json['address'],
      );
    }
}