class WilayahKecamatanModel {
  String? id;
  String? regencyId;
  String? name;

  WilayahKecamatanModel({this.id, this.regencyId, this.name});

  @override
  String toString() {
    return 'WilayahKecamatanModel(id: $id, regencyId: $regencyId, name: $name)';
  }

  factory WilayahKecamatanModel.fromJson(Map<String, dynamic> json) {
    return WilayahKecamatanModel(
      id: json['id'] as String?,
      regencyId: json['regency_id'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'regency_id': regencyId,
        'name': name,
      };

  WilayahKecamatanModel copyWith({
    String? id,
    String? regencyId,
    String? name,
  }) {
    return WilayahKecamatanModel(
      id: id ?? this.id,
      regencyId: regencyId ?? this.regencyId,
      name: name ?? this.name,
    );
  }
}
