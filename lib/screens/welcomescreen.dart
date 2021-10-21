import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:learning_ui/custom-widgets/welcome_slide.dart';
import 'package:learning_ui/screens/login.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: CarouselSlider(
                options: CarouselOptions(height: double.infinity),
                items: [
                  WelcomeSlide(
                    image: "assets/images/slide_1.png",
                    title: "Get Fresh Food",
                    subTitle: "Get Fresh Food For Your Family",
                  ),
                  WelcomeSlide(
                    image: "assets/images/slide_2.png",
                    title: "SecurePayments",
                    subTitle: "All Your Payments are secured",
                  ),
                  WelcomeSlide(
                    image: "assets/images/slide_3.png",
                    title: "Fast Delivery",
                    subTitle: "Don't wait too much, we deliver fast",
                  ),
                ],
              ),
            )),
            Container(
              height: 70,
              width: double.infinity,
              child: ElevatedButton(
                child: Text(
                  'Getting Started',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Get.to(() => LoginScreen());
                },
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
