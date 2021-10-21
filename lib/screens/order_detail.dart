import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  Map orderObject;
  OrderDetails({this.orderObject});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("#${orderObject["id"]} - ${orderObject["status"]}"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text("Order"),
              subtitle: Text("${orderObject["dateString"]}"),
              trailing: Text("${orderObject["id"]}"),
            ),
            ListTile(
              title: Text("Status"),
              trailing: Text("${orderObject["status"]}"),
            ),
            ListTile(
              title: Text("Delivery"),
              subtitle: Text("${orderObject["deliveryAddress"]}"),
              trailing: Text("${orderObject["paymentMethod"]}"),
              isThreeLine: true,
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              padding: EdgeInsets.only(left: 12),
              child: Text(
                "CART ITEMS",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: Container(
              child: ListView.builder(
                  itemCount: orderObject["cartItems"].length,
                  itemBuilder: (bc, index) {
                    return ListTile(
                      title:
                          Text("${orderObject["cartItems"][index]["title"]}"),
                      subtitle: Text(
                          "Qty: ${orderObject["cartItems"][index]["qty"]} X ₹ ${orderObject["cartItems"][index]["price"]}"),
                      trailing:
                          Text("₹ ${orderObject["cartItems"][index]["total"]}"),
                    );
                  }),
            )),
            Container(
              height: 80,
              color: Colors.green,
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    '₹ ${orderObject["cartTotal"]}',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
