import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DbService extends GetxService {
  final GetStorage _getStore;

  DbService._(this._getStore);

  static DbService? _instance;

  factory DbService.init(GetStorage getStore) {
    _instance ??= DbService._(getStore);
    return _instance!;
  }

  Future<void> writeData<T>(String key, T val) async {
    await _getStore.write(key, val);
  }

  // T? readData<T>(String key) {
  //   return _getStore.read<T>(key);
  // }

  T? readData<T>(String key) {
    final data = _getStore.read(key);
    return data is T ? data : null;
  }

  Future<void> delete(String key) async {
    await _getStore.remove(key);
  }
}
