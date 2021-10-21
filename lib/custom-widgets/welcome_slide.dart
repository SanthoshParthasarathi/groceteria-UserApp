import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WelcomeSlide extends StatelessWidget {
  String image;
  String title;
  String subTitle;

  WelcomeSlide({this.image, this.title, this.subTitle});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 14, left: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            scale: 1,
            height: 400,
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(subTitle)
        ],
      ),
    );
  }
}
