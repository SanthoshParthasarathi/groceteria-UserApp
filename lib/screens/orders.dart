import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_ui/screens/order_detail.dart';

class MyOrdersScreen extends StatelessWidget {
  List _orders = [
    {
      "id": "12345",
      "status": "Completed",
      "paymentMethod": "COD",
      "deliveryAddress": "NO.10/126,2nd Street,Krishna Nagar,WestTambaram",
      "dateString": "21 May 2025",
      "cartTotal": 630.0,
      "itemsCount": 3,
      "cartItems": [
        {
          "imageURL": "assets/images/products/1.jpg",
          "title": "Carrot",
          "qty": 1,
          "price": 20.0,
          "total": 20.0,
        },
        {
          "imageURL": "assets/images/products/5.jpg",
          "title": "Raw Meat",
          "qty": 2,
          "price": 320.0,
          "total": 640.0,
        },
        {
          "imageURL": "assets/images/products/8.jpg",
          "title": "Orange",
          "qty": 1,
          "price": 170.0,
          "total": 170.0,
        }
      ]
    },
    {
      "id": "23412",
      "status": "Cancelled",
      "paymentMethod": "COD",
      "deliveryAddress": "NO.10/126,2nd Street,Krishna Nagar,WestTambaram",
      "dateString": "25 Apr 2025",
      "cartTotal": 190.0,
      "itemsCount": 2,
      "cartItems": [
        {
          "imageURL": "assets/images/products/1.jpg",
          "title": "Carrot",
          "qty": 1,
          "price": 20.0,
          "total": 20.0,
        },
        {
          "imageURL": "assets/images/products/8.jpg",
          "title": "Orange",
          "qty": 1,
          "price": 170.0,
          "total": 170.0,
        }
      ]
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: _orders.length,
          itemBuilder: (bc, index) {
            return ListTile(
              onTap: () {
                Get.to(() => OrderDetails(orderObject: _orders[index]));
              },
              title: Text("#" + _orders[index]["id"]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_orders[index]["dateString"]),
                  Text(_orders[index]["itemsCount"].toString() +
                      " items" +
                      " - ₹ " +
                      _orders[index]["cartTotal"].toString()),
                ],
              ),
              trailing: Text(_orders[index]["status"]),
              isThreeLine: true,
            );
          }),
    );
  }
}
