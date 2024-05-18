class WilayahKelurahanModel {
  String? id;
  String? districtId;
  String? name;

  WilayahKelurahanModel({this.id, this.districtId, this.name});

  @override
  String toString() {
    return 'WilayahKelurahanModel(id: $id, districtId: $districtId, name: $name)';
  }

  factory WilayahKelurahanModel.fromJson(Map<String, dynamic> json) {
    return WilayahKelurahanModel(
      id: json['id'] as String?,
      districtId: json['district_id'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'district_id': districtId,
        'name': name,
      };

  WilayahKelurahanModel copyWith({
    String? id,
    String? districtId,
    String? name,
  }) {
    return WilayahKelurahanModel(
      id: id ?? this.id,
      districtId: districtId ?? this.districtId,
      name: name ?? this.name,
    );
  }
}
