import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:technical_test_assist/services/employee/employee_connect.dart';

import '../../../data/models/employee_model/employee_model.dart';
import '../../../routes/app_pages.dart';

enum Type { add, update }

class MainController extends GetxController
    with StateMixin<List<EmployeeModel>> {
  late final EmployeeConnect _employeeConn;

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    _employeeConn = EmployeeConnect();
    _fetchEmployee();
  }

  Future<void> _fetchEmployee() async {
    change(null, status: RxStatus.loading());

    try {
      final res = await _employeeConn.fetchEmployee;

      if (res.isOk) {
        final List<dynamic>? dataList = res.body;

        if (dataList != null && dataList.isNotEmpty) {
          final listEmployeeModel =
              dataList.map((e) => EmployeeModel.fromJson(e)).toList();

          change(listEmployeeModel, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.empty());
        }
      }
    } catch (e) {
      logger.e('Error fetching employee $e');
      change(null, status: RxStatus.error('$e'));
    }
  }

  void moveToForm({
    String? id,
    required Type type,
    EmployeeModel? data,
  }) {
    Get.toNamed(
      Routes.EMPLOYEE_FORM,
      arguments: {
        'id': id,
        'type': type,
        'data': data,
      },
    )?.then((value) {
      if (value) {
        _fetchEmployee();
      }
    });
  }
}
