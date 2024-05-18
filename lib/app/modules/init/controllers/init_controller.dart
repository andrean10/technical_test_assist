import 'package:get/get.dart';
import 'package:logger/logger.dart';

class InitController extends GetxController {
  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {}
}
