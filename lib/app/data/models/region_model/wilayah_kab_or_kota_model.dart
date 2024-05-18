class WilayahKabOrKotaModel {
  String? id;
  String? provinceId;
  String? name;

  WilayahKabOrKotaModel({this.id, this.provinceId, this.name});

  @override
  String toString() {
    return 'WilayahKabOrKotaModel(id: $id, provinceId: $provinceId, name: $name)';
  }

  factory WilayahKabOrKotaModel.fromJson(Map<String, dynamic> json) {
    return WilayahKabOrKotaModel(
      id: json['id'] as String?,
      provinceId: json['province_id'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'province_id': provinceId,
        'name': name,
      };

  WilayahKabOrKotaModel copyWith({
    String? id,
    String? provinceId,
    String? name,
  }) {
    return WilayahKabOrKotaModel(
      id: id ?? this.id,
      provinceId: provinceId ?? this.provinceId,
      name: name ?? this.name,
    );
  }
}
