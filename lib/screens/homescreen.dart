import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:learning_ui/custom-widgets/category_badge.dart';
import 'package:learning_ui/custom-widgets/product_card.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  List _products = [
    {
      "imageURL": "assets/images/products/1.jpg",
      "title": "Carrot",
      "price": 40.0,
    },
    {
      "imageURL": "assets/images/products/2.jpg",
      "title": "Gourd",
      "price": 30.0,
    },
    {
      "imageURL": "assets/images/products/3.jpg",
      "title": "Meat",
      "price": 400.0,
    },
    {
      "imageURL": "assets/images/products/4.jpg",
      "title": "Lettuce",
      "price": 60.0,
    },
    {
      "imageURL": "assets/images/products/5.jpg",
      "title": "Meat Big Piece",
      "price": 320.0,
    },
    {
      "imageURL": "assets/images/products/6.jpg",
      "title": "Pomegranate",
      "price": 180.0,
    },
    {
      "imageURL": "assets/images/products/7.jpg",
      "title": "Strawberry",
      "price": 540.0,
    },
    {
      "imageURL": "assets/images/products/8.jpg",
      "title": "Orange",
      "price": 170.0,
    },
    {
      "imageURL": "assets/images/products/9.jpg",
      "title": "spinach",
      "price": 70.0,
    },
    {
      "imageURL": "assets/images/products/10.jpg",
      "title": "Cabbage",
      "price": 26.0,
    },
  ];

  List _categories = [
    "All",
    "Vegetables",
    "Meat",
    "Fruits",
    "Snacks",
    "Drinks",
    "Oils",
    "Daily Needs"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text(
          "Groceteria",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.search),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: CarouselSlider(
                options: CarouselOptions(autoPlay: true),
                items: [
                  Container(
                    child: Image.asset("assets/images/offers/1.png"),
                    padding: EdgeInsets.all(4),
                  ),
                  Container(
                    child: Image.asset("assets/images/offers/2.png"),
                    padding: EdgeInsets.all(4),
                  ),
                  Container(
                    child: Image.asset("assets/images/offers/3.png"),
                    padding: EdgeInsets.all(4),
                  ),
                ],
              ),
            ),
            Container(
              height: 45,
              child: ListView.builder(
                  itemCount: _categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (bc, index) {
                    return CategoryBadge(
                      title: "${_categories[index]}",
                    );
                  }),
            ),
            Container(
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemCount: _products.length,
                  itemBuilder: (bc, index) {
                    return ProductCard(
                      id: _products[index]["id"],
                      imageURL: _products[index]["imageURL"],
                      title: _products[index]["title"],
                      price: _products[index]["price"],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
