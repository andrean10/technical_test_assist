class KecamatanModel {
  String? id;
  String? regencyId;
  String? name;

  KecamatanModel({this.id, this.regencyId, this.name});

  @override
  String toString() {
    return 'KecamatanModel(id: $id, regencyId: $regencyId, name: $name)';
  }

  factory KecamatanModel.fromJson(Map<String, dynamic> json) => KecamatanModel(
        id: json['id'] as String?,
        regencyId: json['regency_id'] as String?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'regency_id': regencyId,
        'name': name,
      };

  KecamatanModel copyWith({
    String? id,
    String? regencyId,
    String? name,
  }) {
    return KecamatanModel(
      id: id ?? this.id,
      regencyId: regencyId ?? this.regencyId,
      name: name ?? this.name,
    );
  }
}
