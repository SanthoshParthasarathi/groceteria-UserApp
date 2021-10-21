import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_ui/controllers/cart.dart';
import 'package:learning_ui/custom-widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  CartController _cartController = Get.put(CartController());
  // List _cartItems = [
  //   {
  //     "imageURL": "assets/images/products/1.jpg",
  //     "title": "Carrot",
  //     "qty": 1,
  //     "price": 20.0,
  //     "total": 20.0,
  //   },
  //   {
  //     "imageURL": "assets/images/products/5.jpg",
  //     "title": "Raw Meat",
  //     "qty": 2,
  //     "price": 320.0,
  //     "total": 640.0,
  //   },
  //   {
  //     "imageURL": "assets/images/products/8.jpg",
  //     "title": "Orange",
  //     "qty": 1,
  //     "price": 170.0,
  //     "total": 170.0,
  //   }
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(
          () => Container(
              child: _cartController.getTotalQuantity() == 0
                  ? Text("Cart is empty")
                  : Text("Cart - ${_cartController.getTotalQuantity()} Items")),
        ),
      ),
      body: Container(
        child: _cartController.getTotalQuantity() == 0
            ? Center(child: Text("No Items in Cart"))
            : Column(
                children: [
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                          itemCount: _cartController.cart.length,
                          itemBuilder: (bc, index) {
                            return CartItem(
                              imageUrl: _cartController.cart[index]["imageURL"],
                              title: _cartController.cart[index]["title"],
                              qty: _cartController.cart[index]["qty"],
                              price: _cartController.cart[index]["price"],
                              total: _cartController.cart[index]["total"],
                            );
                          }),
                    ),
                  ),
                  ListTile(
                    title: Text("Delivery Address"),
                    subtitle:
                        Text("NO.10/126,2nd Street,Krishna Nagar,WestTambaram"),
                    trailing: TextButton(
                      child: Text("Change"),
                      onPressed: () {},
                    ),
                  ),
                  ListTile(
                    title: Text("Payment Method"),
                    subtitle: Text("Cash On Delivery"),
                    trailing: TextButton(
                      child: Text("Change"),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    height: 60,
                    padding: EdgeInsets.all(4),
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      child: Obx(() =>
                          Text("Checkout (₹ ${_cartController.getTotal()})  ")),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
