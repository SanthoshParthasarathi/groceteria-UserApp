import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatelessWidget {
  Map orderObject;

  OrderDetails({
    this.orderObject,
  });

  toDateString(timestamp) {
    var date = DateTime.parse(timestamp.toDate().toString());
    var formatter = DateFormat("dd-MMM-yyyy hh:mm");
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    print(orderObject["cart"]);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("#${orderObject["id"]} - ${orderObject["status"]}"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text("Order"),
              subtitle: Text("${toDateString(orderObject["createdAt"])}"),
              trailing: Text("#${orderObject["id"]}"),
            ),
            ListTile(
              title: Text("Status"),
              trailing: Text("${orderObject["status"]}"),
            ),
            ListTile(
              title: Text("Delivery"),
              subtitle: Text("${orderObject["deliveryAddress"]["address"]}"),
              trailing: Text("${orderObject["paymentMode"]}"),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              padding: EdgeInsets.only(left: 12),
              child: Text(
                "CART ITEMS",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: orderObject["cart"].length,
                itemBuilder: (bc, index) {
                  return ListTile(
                    title: Text(
                      "${orderObject["cart"][index]["title"]}",
                    ),
                    subtitle: Text(
                        "Qty: ${orderObject["cart"][index]["qty"]} x ₹ ${orderObject["cart"][index]["price"]}"),
                    trailing: Text(
                      "₹ ${orderObject["cart"][index]["total"]}",
                    ),
                  );
                },
              ),
            ),
            Container(
              color: Colors.green,
              height: 80,
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TOTAL",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "₹ ${orderObject["cartTotal"]}",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
