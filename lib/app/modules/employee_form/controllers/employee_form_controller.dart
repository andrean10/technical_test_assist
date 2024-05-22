import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:technical_test_assist/app/data/models/employee_model/employee_model.dart';
import 'package:technical_test_assist/app/data/models/employee_model/kabupaten_model.dart';
import 'package:technical_test_assist/app/data/models/employee_model/kecamatan_model.dart';
import 'package:technical_test_assist/app/data/models/employee_model/kelurahan_model.dart';
import 'package:technical_test_assist/app/data/models/employee_model/provinsi_model.dart';
import 'package:technical_test_assist/app/data/models/region_model/wilayah_kab_or_kota_model.dart';
import 'package:technical_test_assist/app/data/models/region_model/wilayah_kecamatan_model.dart';
import 'package:technical_test_assist/app/data/models/region_model/wilayah_kelurahan_model.dart';
import 'package:technical_test_assist/app/data/models/region_model/wilayah_provinsi_model.dart';
import 'package:technical_test_assist/app/modules/main/controllers/main_controller.dart';
import 'package:technical_test_assist/app/modules/widgets/buttons/custom_text_button.dart';
import 'package:technical_test_assist/services/employee/employee_connect.dart';
import 'package:technical_test_assist/services/wilayah_indonesia/wilayah_indonesia_connect.dart';
import 'package:technical_test_assist/shared/shared_theme.dart';

class EmployeeFormController extends GetxController {
  late final WilayahIndonesiaConnect _regionConn;
  late final EmployeeConnect _employeeConn;
  late final Map<String, dynamic> args;

  final isLoading = false.obs;
  final isLoadingDialog = false.obs;

  var title = '';
  var btnTitle = '';
  String? id;
  Type? type;

  final formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final addressC = TextEditingController();
  final provinceC = TextEditingController();
  final kabupatenC = TextEditingController();
  final kecamatanC = TextEditingController();
  final kelurahanC = TextEditingController();

  final nameF = FocusNode();
  final addressF = FocusNode();
  final provinceF = FocusNode();
  final kabupatenF = FocusNode();
  final kecamatanF = FocusNode();
  final kelurahanF = FocusNode();

  final name = ''.obs;
  final address = ''.obs;

  var dataProvince = WilayahProvinsiModel().obs;
  var dataKabAtauKota = WilayahKabOrKotaModel().obs;
  var dataKecamatan = WilayahKecamatanModel().obs;
  var dataKelurahan = WilayahKelurahanModel().obs;

  final tempListProvinsi = <WilayahProvinsiModel>[];
  final tempListKabAtauKota = <WilayahKabOrKotaModel>[];
  final tempListKecamatan = <WilayahKecamatanModel>[];
  final tempListKelurahan = <WilayahKelurahanModel>[];

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _init();

    everAll([
      dataProvince,
      dataKabAtauKota,
      dataKecamatan,
    ], (listData) {
      if (listData is WilayahProvinsiModel) {
        _clearTempWilayahAfterProvince();
      } else if (listData is WilayahKabOrKotaModel) {
        _clearTempWilayahAfterKabOrKota();
      } else if (listData is WilayahKecamatanModel) {
        _clearTempWilayahAfterKecamatan();
      }
    });
  }

  void _clearTempWilayahAfterProvince() {
    _clearKabOrKota();
    _clearKecamatan();
    _clearKelurahan();
  }

  void _clearTempWilayahAfterKabOrKota() {
    _clearKecamatan();
    _clearKelurahan();
  }

  void _clearTempWilayahAfterKecamatan() {
    _clearKelurahan();
  }

  void _clearKabOrKota() {
    tempListKabAtauKota.clear();
    dataKabAtauKota.value = WilayahKabOrKotaModel();
    kabupatenC.clear();
  }

  void _clearKecamatan() {
    tempListKecamatan.clear();
    dataKecamatan.value = WilayahKecamatanModel();
    kecamatanC.clear();
  }

  void _clearKelurahan() {
    tempListKelurahan.clear();
    dataKelurahan.value = WilayahKelurahanModel();
    kelurahanC.clear();
  }

  void _init() {
    _regionConn = WilayahIndonesiaConnect();
    _employeeConn = EmployeeConnect();

    args = Get.arguments as Map<String, dynamic>;
    id = args['id'] as String?;
    type = args['type'] as Type;

    _initTextController();

    if (type == Type.add) {
      title = 'Tambah Data Pegawai';
      btnTitle = 'Simpan';
    } else {
      title = 'Ubah Data Pegawai';
      btnTitle = 'Ubah';
      _initTextUpdate();
    }
  }

  void _initTextController() {
    nameC.addListener(setName);
    addressC.addListener(setAddress);
  }

  void _initTextUpdate() {
    final data = args['data'] as EmployeeModel;
    nameC.text = data.nama ?? '';
    addressC.text = data.jalan ?? '';
    provinceC.text = data.provinsi?.name ?? '';
    kabupatenC.text = data.kabupaten?.name ?? '';
    kecamatanC.text = data.kecamatan?.name ?? '';
    kelurahanC.text = data.kelurahan?.name ?? '';

    dataProvince.value = WilayahProvinsiModel(
      id: data.provinsi?.id,
      name: data.provinsi?.name,
    );
    dataKabAtauKota.value = WilayahKabOrKotaModel(
      id: data.kabupaten?.id,
      name: data.kabupaten?.name,
      provinceId: data.id,
    );
    dataKecamatan.value = WilayahKecamatanModel(
      id: data.kecamatan?.id,
      name: data.kecamatan?.name,
      regencyId: data.kabupaten?.id,
    );
    dataKelurahan.value = WilayahKelurahanModel(
      id: data.kelurahan?.id,
      name: data.kelurahan?.name,
      districtId: data.kecamatan?.id,
    );

    fetchProvince();
    fetchKabupaten();
    fetchKecamatan();
    fetchKelurahan();
  }

  void setName() => name.value = nameC.text;

  void setProvince(WilayahProvinsiModel value) {
    provinceC.text = value.name ?? '';
    dataProvince.value = value;
  }

  void setKabupaten(WilayahKabOrKotaModel value) {
    kabupatenC.text = value.name ?? '';
    dataKabAtauKota.value = value;
  }

  void setKecamatan(WilayahKecamatanModel value) {
    kecamatanC.text = value.name ?? '';
    dataKecamatan.value = value;
  }

  void setKelurahan(WilayahKelurahanModel value) {
    kelurahanC.text = value.name ?? '';
    dataKelurahan.value = value;
  }

  void setAddress() => address.value = addressC.text;

  void confirm() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(Get.context!).unfocus();

    final data = EmployeeModel(
      nama: name.value,
      jalan: address.value,
      provinsi: ProvinsiModel(
        id: dataProvince.value.id,
        name: dataProvince.value.name,
      ),
      kabupaten: KabupatenModel(
        id: dataKabAtauKota.value.id,
        provinceId: dataProvince.value.id,
        name: dataKabAtauKota.value.name,
      ),
      kecamatan: KecamatanModel(
        id: dataKecamatan.value.id,
        regencyId: dataKabAtauKota.value.id,
        name: dataKecamatan.value.name,
      ),
      kelurahan: KelurahanModel(
        id: dataKelurahan.value.id,
        districtId: dataKecamatan.value.id,
        name: dataKelurahan.value.name,
      ),
    ).toJson();

    if (type == Type.add) {
      insertEmployee(data);
    } else {
      updateEmployee(id: id ?? '0', data: data);
    }
  }

  Future<void> insertEmployee(Map<String, dynamic> data) async {
    isLoading.value = true;

    try {
      final res = await _employeeConn.insertEmployee(data);

      if (res.isOk) {
        showSnackBar(
          'Berhasil',
          'Berhasil menambahkan data pegawai',
          SharedTheme.successColor,
        );
        moveToMain();
      }
    } catch (e) {
      logger.e('Error insert employee $e');

      showSnackBar(
        'Gagal',
        'Gagal menambahkan data pegawai',
        SharedTheme.errorColor,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateEmployee({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    isLoading.value = true;

    try {
      final res = await _employeeConn.updateEmployee(id: id, data: data);

      if (res.isOk) {
        showSnackBar(
          'Berhasil',
          'Berhasil mengubah data pegawai',
          SharedTheme.successColor,
        );
        moveToMain();
      }
    } catch (e) {
      logger.e('Error update employee $e');

      showSnackBar(
        'Gagal',
        'Gagal menambahkan data pegawai',
        SharedTheme.errorColor,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteEmployee(String id) async {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Peringatan'),
          content:
              const Text('Apakah anda yakin ingin menghapus data pegawai ini?'),
          actions: [
            CustomTextButton(
              child: const Text('Tidak'),
              onPressed: () => Get.back(),
            ),
            Obx(
              () => CustomTextButton(
                state: isLoadingDialog.value,
                onPressed: () async {
                  isLoadingDialog.value = true;

                  try {
                    final res = await _employeeConn.deleteEmployee(id);

                    if (res.isOk) {
                      showSnackBar(
                        'Berhasil',
                        'Berhasil menghapus data pegawai',
                        SharedTheme.successColor,
                      );

                      Get.back();
                      moveToMain();
                    }
                  } catch (e) {
                    logger.e('Error delete employee ');

                    showSnackBar(
                      'Gagal',
                      'Gagal menghapus data pegawai',
                      SharedTheme.errorColor,
                    );
                  } finally {
                    isLoadingDialog.value = false;
                  }
                },
                child: const Text('Iya'),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<List<WilayahProvinsiModel>> fetchProvince() async {
    try {
      if (tempListProvinsi.isEmpty) {
        final res = await _regionConn.getProvinsi;

        if (res.isOk) {
          final List<dynamic>? dataList = res.body;

          if (dataList != null && dataList.isNotEmpty) {
            final listProvinces =
                dataList.map((e) => WilayahProvinsiModel.fromJson(e)).toList();

            // set to temporary
            tempListProvinsi.addAll(listProvinces);
          }
        }
      }

      return tempListProvinsi;
    } catch (e) {
      logger.e('Error fetching employee $e');
    }

    return [];
  }

  Future<List<WilayahKabOrKotaModel>> fetchKabupaten() async {
    try {
      if (tempListKabAtauKota.isEmpty) {
        final res = await _regionConn
            .getKabAtauKota(int.parse(dataProvince.value.id ?? '0'));

        if (res.isOk) {
          final List<dynamic>? dataList = res.body;

          if (dataList != null && dataList.isNotEmpty) {
            final listKabOrKota =
                dataList.map((e) => WilayahKabOrKotaModel.fromJson(e)).toList();

            // set to temporary
            tempListKabAtauKota.addAll(listKabOrKota);
          }
        }
      }

      return tempListKabAtauKota;
    } catch (e) {
      logger.e('Error fetching employee $e');
    }

    return [];
  }

  Future<List<WilayahKecamatanModel>> fetchKecamatan() async {
    try {
      if (tempListKecamatan.isEmpty) {
        final res = await _regionConn
            .getKecamatan(int.parse(dataKabAtauKota.value.id ?? '0'));

        if (res.isOk) {
          final List<dynamic>? dataList = res.body;

          if (dataList != null && dataList.isNotEmpty) {
            final listKecamatan =
                dataList.map((e) => WilayahKecamatanModel.fromJson(e)).toList();

            // set to temporary
            tempListKecamatan.addAll(listKecamatan);
          }
        }
      }

      return tempListKecamatan;
    } catch (e) {
      logger.e('Error fetching employee $e');
    }

    return [];
  }

  Future<List<WilayahKelurahanModel>> fetchKelurahan() async {
    try {
      if (tempListKelurahan.isEmpty) {
        final res = await _regionConn
            .getKelurahan(int.parse(dataKecamatan.value.id ?? '0'));

        if (res.isOk) {
          final List<dynamic>? dataList = res.body;

          if (dataList != null && dataList.isNotEmpty) {
            final listKelurahan =
                dataList.map((e) => WilayahKelurahanModel.fromJson(e)).toList();

            // set to temporary
            tempListKelurahan.addAll(listKelurahan);
          }
        }
      }

      return tempListKelurahan;
    } catch (e) {
      logger.e('Error fetching employee $e');
    }

    return [];
  }

  void showSnackBar(
    String title,
    String message,
    Color color,
  ) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Gap(2),
            Text(message),
          ],
        ),
      ),
    );
  }

  void moveToMain() => Get.back(result: true);
}
