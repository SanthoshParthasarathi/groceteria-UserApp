import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_ui/controllers/orders.dart';
import 'package:intl/intl.dart';
import 'package:learning_ui/screens/order_detail.dart';

class MyOrdersScreen extends StatelessWidget {
  OrderController _orderController = Get.put(OrderController());

  toDateString(timestamp) {
    var date = DateTime.parse(timestamp.toDate().toString());
    var formatter = DateFormat("dd-MMM-yyyy");
    return formatter.format(date);
  }

  // List _orders = [
  //   {
  //     "id": "12345",
  //     "status": "Completed",
  //     "paymentMethod": "COD",
  //     "deliveryAddress": "NO.10/126,2nd Street,Krishna Nagar,WestTambaram",
  //     "dateString": "21 May 2025",
  //     "cartTotal": 630.0,
  //     "itemsCount": 3,
  //     "cartItems": [
  //       {
  //         "imageURL": "assets/images/products/1.jpg",
  //         "title": "Carrot",
  //         "qty": 1,
  //         "price": 20.0,
  //         "total": 20.0,
  //       },
  //       {
  //         "imageURL": "assets/images/products/5.jpg",
  //         "title": "Raw Meat",
  //         "qty": 2,
  //         "price": 320.0,
  //         "total": 640.0,
  //       },
  //       {
  //         "imageURL": "assets/images/products/8.jpg",
  //         "title": "Orange",
  //         "qty": 1,
  //         "price": 170.0,
  //         "total": 170.0,
  //       }
  //     ]
  //   },
  //   {
  //     "id": "23412",
  //     "status": "Cancelled",
  //     "paymentMethod": "COD",
  //     "deliveryAddress": "NO.10/126,2nd Street,Krishna Nagar,WestTambaram",
  //     "dateString": "25 Apr 2025",
  //     "cartTotal": 190.0,
  //     "itemsCount": 2,
  //     "cartItems": [
  //       {
  //         "imageURL": "assets/images/products/1.jpg",
  //         "title": "Carrot",
  //         "qty": 1,
  //         "price": 20.0,
  //         "total": 20.0,
  //       },
  //       {
  //         "imageURL": "assets/images/products/8.jpg",
  //         "title": "Orange",
  //         "qty": 1,
  //         "price": 170.0,
  //         "total": 170.0,
  //       }
  //     ]
  //   }
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: _orderController.orders.length,
          itemBuilder: (bc, index) {
            return ListTile(
              onTap: () {
                Get.to(() =>
                    OrderDetails(orderObject: _orderController.orders[index]));
              },
              title: Text("#" + _orderController.orders[index]["id"]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${toDateString(_orderController.orders[index]["createdAt"])}"),
                  Text("${_orderController.orders[index]["itemCount"]}" +
                      " items" +
                      " - ₹ " +
                      "${_orderController.orders[index]["cartTotal"]}"),
                ],
              ),
              trailing: Text(_orderController.orders[index]["status"]),
              isThreeLine: true,
            );
          }),
    );
  }
}
