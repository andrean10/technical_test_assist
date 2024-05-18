class KelurahanModel {
  String? id;
  String? districtId;
  String? name;

  KelurahanModel({this.id, this.districtId, this.name});

  @override
  String toString() {
    return 'KelurahanModel(id: $id, districtId: $districtId, name: $name)';
  }

  factory KelurahanModel.fromJson(Map<String, dynamic> json) => KelurahanModel(
        id: json['id'] as String?,
        districtId: json['district_id'] as String?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'district_id': districtId,
        'name': name,
      };

  KelurahanModel copyWith({
    String? id,
    String? districtId,
    String? name,
  }) {
    return KelurahanModel(
      id: id ?? this.id,
      districtId: districtId ?? this.districtId,
      name: name ?? this.name,
    );
  }
}
