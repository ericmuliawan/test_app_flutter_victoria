import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/history_controller.dart';
import '../helper/loading_container.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);
  Uint8List convertBase64Image(String base64String) {
    return Base64Decoder().convert(base64String.split(',').last);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
        ),
        body: SingleChildScrollView(
          child: GetX<HistoryController>(
              init: HistoryController(),
              builder: (_) {
                return LoadingContainer(
                    isLoading: _.isLoading.value,
                    child: _.data.isEmpty
                        ? const Center(
                            child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: Text('Tidak ada data!'),
                          ))
                        : ListView(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            children: _.data
                                .map((e) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      color: Colors.transparent,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.memory(
                                                convertBase64Image(
                                                    e.photoName!),
                                                gaplessPlayback: true,
                                                height: 80,
                                                width: 100,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                        'Reviewed By : ${e.reviewName}',
                                                        style: const TextStyle(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                          // '${e.merchant}, ${e.area} ,${e.city}'),
                                                          'Notes : ${e.note}'),
                                                    ]),
                                              ),
                                              SizedBox(
                                                width: 80,
                                                child: Text(e.date == null
                                                    ? ''
                                                    : e.date!),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ))
                                .toList()));
              }),
        ));
  }
}
