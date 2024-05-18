import 'kabupaten_model.dart';
import 'kecamatan_model.dart';
import 'kelurahan_model.dart';
import 'provinsi_model.dart';

class EmployeeModel {
  String? id;
  String? nama;
  ProvinsiModel? provinsi;
  KabupatenModel? kabupaten;
  KecamatanModel? kecamatan;
  KelurahanModel? kelurahan;
  String? jalan;

  EmployeeModel({
    this.id,
    this.nama,
    this.provinsi,
    this.kabupaten,
    this.kecamatan,
    this.kelurahan,
    this.jalan,
  });

  @override
  String toString() {
    return 'EmployeeModel(id: $id, nama: $nama, provinsi: $provinsi, kabupaten: $kabupaten, kecamatan: $kecamatan, kelurahan: $kelurahan, jalan: $jalan)';
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        id: json['id'] as String?,
        nama: json['nama'] as String?,
        provinsi: json['provinsi'] == null
            ? null
            : ProvinsiModel.fromJson(json['provinsi'] as Map<String, dynamic>),
        kabupaten: json['kabupaten'] == null
            ? null
            : KabupatenModel.fromJson(
                json['kabupaten'] as Map<String, dynamic>),
        kecamatan: json['kecamatan'] == null
            ? null
            : KecamatanModel.fromJson(
                json['kecamatan'] as Map<String, dynamic>),
        kelurahan: json['kelurahan'] == null
            ? null
            : KelurahanModel.fromJson(
                json['kelurahan'] as Map<String, dynamic>),
        jalan: json['jalan'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'nama': nama,
        'provinsi': provinsi?.toJson(),
        'kabupaten': kabupaten?.toJson(),
        'kecamatan': kecamatan?.toJson(),
        'kelurahan': kelurahan?.toJson(),
        'jalan': jalan,
      };

  EmployeeModel copyWith({
    String? id,
    String? nama,
    ProvinsiModel? provinsi,
    KabupatenModel? kabupaten,
    KecamatanModel? kecamatan,
    KelurahanModel? kelurahan,
    String? jalan,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      provinsi: provinsi ?? this.provinsi,
      kabupaten: kabupaten ?? this.kabupaten,
      kecamatan: kecamatan ?? this.kecamatan,
      kelurahan: kelurahan ?? this.kelurahan,
      jalan: jalan ?? this.jalan,
    );
  }
}
