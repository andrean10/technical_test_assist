import 'package:get/get.dart';

import '../../utils/constants_connect.dart';

class EmployeeConnect extends GetConnect {
  Future<Response> get fetchEmployee async =>
      await get('${ConstantsConnect.endPointEmployee}/pegawai');

  Future<Response> insertEmployee(Map data) async =>
      await post('${ConstantsConnect.endPointEmployee}/pegawai', data);

  Future<Response> updateEmployee({
    required String id,
    required Map data,
  }) async =>
      await put('${ConstantsConnect.endPointEmployee}/pegawai/$id', data);

  Future<Response> deleteEmployee(String id) async =>
      await delete('${ConstantsConnect.endPointEmployee}/pegawai/$id');
}
