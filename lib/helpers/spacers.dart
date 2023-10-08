import 'package:flutter/material.dart';

Widget verticalSpacer(double? height) {
  return SizedBox(
    height: height,
    width: null,
  );
}

// It Helps me organize code

Widget horizontalSpacer(double? width) {
  return SizedBox(
    height: null,
    width: width,
  );
}
