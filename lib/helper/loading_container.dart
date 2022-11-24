import 'package:flutter/material.dart';

import 'loading.dart';

class LoadingContainer extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  const LoadingContainer(
      {Key? key, required this.isLoading, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        child,
        isLoading
            ? Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.transparent,
                    child: const LoadingIndicator()),
              )
            : Container(),
      ],
    );
  }
}
