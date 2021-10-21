import 'package:flutter/material.dart';

class CategoryBadge extends StatelessWidget {
  String title;
  CategoryBadge({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(top: 2, bottom: 2, left: 20, right: 20),
      margin: EdgeInsets.all(4),
      child: Center(
          child: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      )),
    );
  }
}
