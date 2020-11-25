import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String text;
  Function onPressed;
  bool showProgress;
  bool expanded;
  Color color;
  Color textColor;

  AppButton(this.text,
      {this.onPressed,
      this.showProgress = false,
      this.expanded = true,
      this.color,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expanded ? MediaQuery.of(context).size.width : null,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        color: color,
        child: showProgress
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: TextStyle(color: textColor),
              ),
        padding: EdgeInsets.all(12),
        onPressed: onPressed,
      ),
    );
  }
}
