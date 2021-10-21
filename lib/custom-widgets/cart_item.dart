import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_ui/controllers/cart.dart';

class CartItem extends StatelessWidget {
  CartController _cartController = Get.put(CartController());
  String id;
  String imageURL;
  String title;
  int qty;
  double price;
  double total;

  CartItem(
      {this.id, this.imageURL, this.title, this.qty, this.price, this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              child: Image.asset(
                imageURL,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$title",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text("Qty $qty x ₹ $price"),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  RawMaterialButton(
                    onPressed: () {
                      _cartController.addToCart({
                        "id": id,
                        "title": title,
                        "price": price,
                        "qty": qty,
                        "imageURL": imageURL
                      });
                    },
                    child: Icon(Icons.add, color: Colors.white, size: 16),
                    fillColor: Colors.green,
                    shape: CircleBorder(),
                    constraints: BoxConstraints(),
                    elevation: 0,
                    padding: EdgeInsets.all(4),
                  ),
                  Text("$qty"),
                  RawMaterialButton(
                    onPressed: () {
                      _cartController.removeFromCart({
                        "id": id,
                        "title": title,
                        "price": price,
                        "qty": qty,
                        "imageURL": imageURL
                      });
                    },
                    child: Icon(Icons.remove, color: Colors.white, size: 16),
                    fillColor: Colors.green,
                    shape: CircleBorder(),
                    constraints: BoxConstraints(),
                    elevation: 0,
                    padding: EdgeInsets.all(4),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Text(
              "₹ $total",
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
