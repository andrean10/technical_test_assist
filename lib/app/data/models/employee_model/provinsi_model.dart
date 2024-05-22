class ProvinsiModel {
  String? id;
  String? name;

  ProvinsiModel({this.id, this.name});

  @override
  String toString() => 'ProvinsiModel(id: $id, name: $name)';

  factory ProvinsiModel.fromJson(Map<String, dynamic>? json) => ProvinsiModel(
        id: json?['id'] == null ? null : json!['id'] as String,
        name: json?['name'] == null ? null : json!['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  ProvinsiModel copyWith({
    String? id,
    String? name,
  }) {
    return ProvinsiModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
