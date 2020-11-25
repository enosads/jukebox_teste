import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  double thickness;
  double height;

  AppDivider({this.thickness, this.height});

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: 0,
      thickness: thickness ?? 0.5,
      height: height ?? 0.5,
    );
  }
}
