import 'package:flutter/material.dart';
import 'package:flutter_app_test_victoria/controller/user_controller.dart';
import 'package:flutter_app_test_victoria/model/user.dart';
import 'package:flutter_app_test_victoria/pages/closing.dart';
import 'package:flutter_app_test_victoria/pages/review_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../helper/dbHelper.dart';
import '../helper/utility.dart';
import '../model/review.dart';
import 'package:intl/intl.dart';

class ReviewController extends GetxController {
  var isLoading = false.obs;
  final dbPhoto = DBHelper.instance;
  final UserController user = Get.put(UserController());
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String imgString = '';
  String formattedDate = '';

  @override
  void onInit() async {
    super.onInit();
  }

  final TextEditingController reviewNote = TextEditingController();
  var reviewImagePath = ''.obs;

  getFotoReview() async {
    formattedDate = formatter.format(now);
    print(formattedDate);
    isLoading(true);
    var image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 70);
    var path = image?.path;
    if (path != null) {
      reviewImagePath(path);
      imgString = Utility.base64String(await image!.readAsBytes());

      // refreshImages();
    }
    isLoading(false);
  }

  submit() async {
    isLoading.value = true;

    print(imgString);
    photo photo1 =
        photo(imgString, user.getUsername(), formattedDate, reviewNote.text);
    dbPhoto.save(photo1);
    Get.offAll(const closing());
  }
}
