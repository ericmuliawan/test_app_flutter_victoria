import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_test_victoria/controller/review_controller.dart';
import 'package:flutter_app_test_victoria/controller/user_controller.dart';
import 'package:get/get.dart';

import '../helper/dbHelper.dart';
import '../helper/loading_container.dart';
import '../helper/utility.dart';

class review extends StatefulWidget {
  const review({Key? key}) : super(key: key);

  @override
  State<review> createState() => _reviewState();
}

class _reviewState extends State<review> {
  final UserController user = Get.put(UserController());
  final ReviewController review = Get.put(ReviewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: GetX<ReviewController>(
                init: ReviewController(),
                builder: (_) {
                  return LoadingContainer(
                      isLoading: _.isLoading.value,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: new Text(
                                  'REVIEW PRODUCT',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.black45),
                                ),
                              ),
                              buttonFoto(() async => await _.getFotoReview()),
                              _.reviewImagePath.value.isNotEmpty
                                  ? Image.file(File(_.reviewImagePath.value))
                                  : Container(),
                              const SizedBox(height: 10),
                              TextFormField(
                                  controller: _.reviewNote,
                                  decoration:
                                      const InputDecoration(labelText: 'Note')),
                              const SizedBox(height: 15),
                              const SizedBox(height: 20),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      minimumSize:
                                          const Size(double.infinity, 45),
                                      backgroundColor: Colors.blueAccent),
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    if (_.reviewNote.text == '') {
                                      Utility.snackError(
                                          'Note Tidak Boleh Kosong');
                                    } else {
                                      print(user.getUsername().toString());
                                      FocusScope.of(context).unfocus();
                                      await review.submit();
                                    }
                                    // user.isLoading;
                                  },
                                  child: const Text(
                                    'Submit Review',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ]),
                      ));
                })));
  }

  Widget buttonFoto(VoidCallback func) {
    return ElevatedButton.icon(
        style: TextButton.styleFrom(
            fixedSize: const Size(100, 10),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10)),
        onPressed: func,
        icon: const Icon(
          Icons.camera_alt_outlined,
          size: 14,
        ),
        label: const Text(
          'Ambil Foto',
          style: TextStyle(fontSize: 12),
        ));
    // return TextButton(
    //     style: TextButton.styleFrom(
    //         padding: const EdgeInsets.all(2),
    //         fixedSize: const Size(70, 50),
    //         backgroundColor: blue),
    //     onPressed: () => func,
    //     child: const Text(
    //       'Ambil Foto',
    //       style: TextStyle(color: Colors.white, fontSize: 11),
    //     ));
  }
}
