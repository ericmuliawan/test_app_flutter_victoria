import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          ),
        ),
      );
}
