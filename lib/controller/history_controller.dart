import 'package:flutter_app_test_victoria/controller/user_controller.dart';
import 'package:flutter_app_test_victoria/model/review.dart';
import 'package:get/get.dart';

import '../helper/dbHelper.dart';

class HistoryController extends GetxController {
  static HistoryController get to => Get.find();
  final dbPhoto = DBHelper.instance;

  final UserController auth = Get.put(UserController());

  var isLoading = false.obs;
  var data = <photo>[].obs;

  @override
  void onInit() async {
    await getData();
    super.onInit();
  }

  getData() async {
    isLoading(true);

    var result = await dbPhoto.getPhotos();

    if (result.isNotEmpty) {
      for (var row in result) {
        data.add(row);
      }
    }
    isLoading(false);
  }
}
