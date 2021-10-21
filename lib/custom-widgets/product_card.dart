import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_ui/controllers/cart.dart';

class ProductCard extends StatelessWidget {
  CartController _cartController = Get.put(CartController());
  String id;
  String imageURL;
  String title;
  double price;

  ProductCard({this.id, this.imageURL, this.title, this.price});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.only(top: 4),
      child: Stack(
        children: [
          Align(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  imageURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.black.withOpacity(0.3),
                padding: EdgeInsets.only(left: 4, right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "₹ ${price.toString()}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          _cartController.addToCart({
                            "id": id,
                            "title": title,
                            "price": price,
                            "qty": 1,
                            "imageURL": imageURL
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
