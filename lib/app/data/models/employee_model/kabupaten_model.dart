class KabupatenModel {
  String? id;
  String? provinceId;
  String? name;

  KabupatenModel({this.id, this.provinceId, this.name});

  @override
  String toString() {
    return 'KabupatenModel(id: $id, provinceId: $provinceId, name: $name)';
  }

  factory KabupatenModel.fromJson(Map<String, dynamic>? json) => KabupatenModel(
        id: json?['id'] == null ? null : json!['id'] as String?,
        provinceId: json?['province_id'] == null
            ? null
            : json!['province_id'] as String?,
        name: json?['name'] == null ? null : json!['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'province_id': provinceId,
        'name': name,
      };

  KabupatenModel copyWith({
    String? id,
    String? provinceId,
    String? name,
  }) {
    return KabupatenModel(
      id: id ?? this.id,
      provinceId: provinceId ?? this.provinceId,
      name: name ?? this.name,
    );
  }
}
