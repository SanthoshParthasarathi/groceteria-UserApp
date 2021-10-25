import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_ui/controllers/address.dart';
import 'package:learning_ui/controllers/cart.dart';
import 'package:learning_ui/controllers/orders.dart';
import 'package:learning_ui/custom-widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  CartController _cartController = Get.put(CartController());
  AddressController _addressController = Get.put(AddressController());
  OrderController _orderController = Get.put(OrderController());

  String noAddress = "Select a Address to deliver";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Container(
            child: _cartController.getTotalQuantity() == 0
                ? Text("Cart is Empty")
                : Text("Cart - ${_cartController.getTotalQuantity()} Items"),
          ),
        ),
      ),
      body: Obx(
        () => Container(
          child: _cartController.getTotalQuantity() == 0
              ? Center(child: Text("No Items In Cart"))
              : Column(
                  children: [
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                          itemCount: _cartController.cart.length,
                          itemBuilder: (bc, index) {
                            return CartItem(
                              id: _cartController.cart[index]["id"],
                              imageURL: _cartController.cart[index]["imageURL"],
                              title: _cartController.cart[index]["title"],
                              qty: _cartController.cart[index]["qty"],
                              price: _cartController.cart[index]["price"],
                              total: _cartController.cart[index]["total"],
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Obx(
                            () => ListTile(
                              title: Text("Delivery Address"),
                              subtitle: _cartController
                                          .selectedAddress["address"] ==
                                      null
                                  ? Text("Select a address to deliver")
                                  : Text(
                                      "${_cartController.selectedAddress["address"]}"),
                              trailing: TextButton(
                                child: Text("Change"),
                                onPressed: () {
                                  print(
                                      "${_cartController.selectedAddress["address"]}");
                                  _addressController.getAllAddresses();
                                  Get.bottomSheet(
                                    BottomSheet(
                                        onClosing: () {},
                                        builder: (bc) {
                                          return Wrap(
                                            children: _addressController
                                                .addresses
                                                .map((a) {
                                              return ListTile(
                                                  title: Text("${a['tag']}"),
                                                  subtitle:
                                                      Text("${a['address']}"),
                                                  onTap: () {
                                                    _cartController
                                                        .selectedAddress
                                                        .value = a;
                                                    if (Get.isBottomSheetOpen)
                                                      Get.back();
                                                  });
                                            }).toList(),
                                          );
                                        }),
                                  );
                                },
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text("Payment Method"),
                            subtitle: Obx(
                              () => Text("${_cartController.paymentMethod}"),
                            ),
                            trailing: TextButton(
                              child: Text("Change"),
                              onPressed: () {
                                Get.bottomSheet(
                                  BottomSheet(
                                      onClosing: () {},
                                      builder: (bc) {
                                        return Wrap(
                                          children: [
                                            ListTile(
                                                title: Text("Cash on Delivery"),
                                                onTap: () {
                                                  _cartController.paymentMethod
                                                      .value = "COD";
                                                  if (Get.isBottomSheetOpen)
                                                    Get.back();
                                                }),
                                            ListTile(
                                                title: Text("Card"),
                                                onTap: () {
                                                  _cartController.paymentMethod
                                                      .value = "STRIPE";
                                                  if (Get.isBottomSheetOpen)
                                                    Get.back();
                                                }),
                                            ListTile(
                                                title: Text("PayPal"),
                                                onTap: () {
                                                  _cartController.paymentMethod
                                                      .value = "PAYPAL";
                                                  if (Get.isBottomSheetOpen)
                                                    Get.back();
                                                }),
                                            ListTile(
                                                title: Text("Others"),
                                                onTap: () {
                                                  _cartController.paymentMethod
                                                      .value = "OTHERS";
                                                  if (Get.isBottomSheetOpen)
                                                    Get.back();
                                                })
                                          ],
                                        );
                                      }),
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4.0),
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                              ),
                              child: Obx(
                                () => Text(
                                    "Checkout (₹ ${_cartController.getTotal()})"),
                              ),
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "Confirmation",
                                  content: Text(
                                      "Are You sure want to place this order?"),
                                  onConfirm: () {
                                    _orderController.createOrder();
                                  },
                                  onCancel: () {
                                    Get.back();
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
