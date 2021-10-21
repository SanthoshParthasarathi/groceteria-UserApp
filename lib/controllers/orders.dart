import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:learning_ui/controllers/cart.dart';

class OrderController extends GetxController {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  CartController _cartController = Get.put(CartController());

  var orders = [].obs;

  @override
  onInit() {
    super.onInit();
    this.fetchOrders();
  }

  fetchOrders() {
    _db
        .collection("orders")
        .where("userId", isEqualTo: _auth.currentUser.uid)
        .snapshots()
        .listen((res) {
      var _tmp = [];
      res.docs.forEach((order) {
        _tmp.add({"id": order.id, ...order.data()});
      });
      orders.assignAll(_tmp);
    });
  }

  createOrder() {
    var obj = {
      "userId": _auth.currentUser.uid,
      "cart": _cartController.cart.value,
      "deliveryAddress": _cartController.selectedAddress.value,
      "paymentMode": _cartController.paymentMethod.value,
      "createdAt": FieldValue.serverTimestamp(),
      "cartTotal": _cartController.getTotal(),
      "itemCount": _cartController.getTotalQuantity(),
      "status": "PROCESS"
    };

    _db.collection("orders").add(obj).then((res) {
      print("order placed");
      _cartController.clearCart();
      Get.back();
    }).catchError((e) {
      print(e);
      print("error");
    });
  }
}
