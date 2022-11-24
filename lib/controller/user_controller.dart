import 'package:flutter_app_test_victoria/pages/history_screen.dart';
import 'package:flutter_app_test_victoria/pages/review_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  final GetStorage storage = GetStorage();
  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  setUsername(username) => storage.write('username', username);
  getUsername() => storage.read('username');

  login(username, usia, gender) async {
    print(username.toString());
    isLoading.value = true;
    setUsername(username);
    print(getUsername().toString());
    Get.offAll(const review());
    isLoading.value = false;
  }

  history() async {
    Get.offAll(const HistoryScreen());
  }
}
