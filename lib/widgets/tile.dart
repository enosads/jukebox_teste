import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  Widget leading;
  Widget title;
  String subtitle;
  TextAlign subtitleAlign;
  bool bold;
  bool isThreeLine;
  bool fittedTitle;
  Widget trailing;

  Tile({
    this.leading,
    this.title,
    this.subtitle,
    this.bold = false,
    this.isThreeLine = false,
    this.fittedTitle = false,
    this.trailing,
    this.subtitleAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: leading,
        trailing: trailing,
        title: title,
        subtitle: subtitle != null
            ? Text(
                subtitle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: subtitleAlign,
              )
            : null,
        isThreeLine: isThreeLine,
      ),
    );
  }
}

class TitleTile extends StatelessWidget {
  String title;
  bool bold;
  Color color;

  TitleTile(this.title, {this.bold = false, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: bold ? 20 : null,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: color),
    );
  }
}
