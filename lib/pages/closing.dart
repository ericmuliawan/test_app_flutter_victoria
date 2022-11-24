import 'package:flutter/material.dart';
import 'package:flutter_app_test_victoria/pages/home.dart';

class closing extends StatefulWidget {
  const closing({super.key});

  @override
  State<closing> createState() => _closingState();
}

class _closingState extends State<closing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
            color: Colors.white,
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/vci_9.png',
                  height: 200,
                  width: 400,
                ),
                const Text(
                  'Selamat, Review Berhasil diupload',
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.greenAccent),
                    onPressed: () async {
                      // user.isLoading;
                      FocusScope.of(context).unfocus();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: const Text(
                      'Oke',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            )),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
