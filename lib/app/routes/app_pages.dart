import 'package:get/get.dart';

import '../modules/employee_form/bindings/employee_form_binding.dart';
import '../modules/employee_form/views/employee_form_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.EMPLOYEE_FORM,
      page: () => const EmployeeFormView(),
      binding: EmployeeFormBinding(),
      transition: Transition.cupertino,
    ),
  ];
}
