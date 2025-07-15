import 'package:get/get.dart';

import '../services/db_service.dart';

class DbController extends GetxController {
  static DbController instance = Get.find<DbController>();

  final _service = Get.find<DbService>();

  writeData<T>(String key, T val) {
    _service.writeData(key, val);
  }

  T? readData<T>(String key) {
    return _service.readData(key);
  }

  Future<void> clear(String key) async {
    await _service.delete(key);
  }
}
