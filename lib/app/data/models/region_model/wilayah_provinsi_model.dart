import 'dart:convert';

class WilayahProvinsiModel {
  String? id;
  String? name;

  WilayahProvinsiModel({this.id, this.name});

  @override
  String toString() => 'WilayahProvinsiModel(id: $id, name: $name)';

  factory WilayahProvinsiModel.fromJson(Map<String, dynamic> data) => WilayahProvinsiModel(
        id: data['id'] as String?,
        name: data['name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  String toJson() => json.encode(toMap());

  WilayahProvinsiModel copyWith({
    String? id,
    String? name,
  }) {
    return WilayahProvinsiModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
