import 'package:flutter/material.dart';
import 'package:flutter_app_test_victoria/controller/user_controller.dart';
import 'package:flutter_app_test_victoria/helper/loading_container.dart';
import 'package:flutter_app_test_victoria/helper/utility.dart';
import 'package:flutter_app_test_victoria/pages/review_screen.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../helper/dbHelper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

enum Gender { Pria, Wanita }

class _HomeState extends State<Home> {
  final dbHelper = DatabaseHelper.instance;

  final UserController user = Get.put(UserController());

  final TextEditingController _username = TextEditingController();
  final TextEditingController _usia = TextEditingController();

  final List<String> imgList = [
    'assets/vci_7.jpeg',
    'assets/vci_3.jpeg',
    'assets/vci_4.jpeg',
    'assets/vci_5.jpeg',
    'assets/vci_2.jpeg',
    'assets/vci_8.jpeg'
  ];

  Gender? _character = Gender.Pria;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: Center(
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: LoadingContainer(
                        // height: MediaQuery.of(context).size.height,
                        // width: MediaQuery.of(context).size.width,
                        // padding: EdgeInsets.all(20),
                        // color: Colors.white,
                        isLoading: user.isLoading.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: new Text(
                                'PT VICTORIA CARE INDONESIA',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.black45),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CarouselSlider(
                                items: imgList
                                    .map((item) => Container(
                                          child: Center(
                                              child: Image.asset(item,
                                                  fit: BoxFit.cover,
                                                  width: 1000)),
                                        ))
                                    .toList(),
                                options: CarouselOptions(
                                  height: 200,
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 0.8,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                )),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              child: new Text(
                                'Masukan Data Diri Anda :',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.black45),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                                controller: _username,
                                decoration:
                                    const InputDecoration(labelText: 'Nama')),
                            const SizedBox(height: 10),
                            TextFormField(
                                controller: _usia,
                                // obscureText: true,
                                decoration:
                                    const InputDecoration(labelText: 'Usia')),
                            const SizedBox(height: 10),
                            Text('Jenis Kelamin',
                                style: new TextStyle(
                                    fontSize: 16, color: Colors.black54)),
                            ListTile(
                              title: const Text('Pria'),
                              leading: Radio<Gender>(
                                value: Gender.Pria,
                                groupValue: _character,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('Wanita'),
                              leading: Radio<Gender>(
                                value: Gender.Wanita,
                                groupValue: _character,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 50),
                            TextButton(
                                style: TextButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 45),
                                    backgroundColor: Colors.blueAccent),
                                onPressed: () async {
                                  // user.isLoading;
                                  FocusScope.of(context).unfocus();
                                  if (_username.text == '' ||
                                      _usia.text == '') {
                                    Utility.snackError(
                                        'Nama dan Usia Tidak Boleh Kosong');
                                  } else {
                                    await user.login(
                                        _username.text, _usia.text, _character);
                                  }
                                },
                                child: const Text(
                                  'Start Review',
                                  style: TextStyle(color: Colors.white),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 45),
                                    backgroundColor: Colors.blueAccent),
                                onPressed: () async {
                                  // user.isLoading;
                                  FocusScope.of(context).unfocus();
                                  await user.history();
                                },
                                child: const Text(
                                  'List Review',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        ),
                      )))),
        ));
  }
}
