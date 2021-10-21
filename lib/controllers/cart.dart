import 'package:get/get.dart';

class CartController extends GetxController {
  var cart = [].obs;

  getTotal() {
    num total = 0;
    cart.forEach((p) => total = total + p["total"]);
    // cart.refresh();

    return total;
  }

  getTotalQuantity() {
    num qty = 0;
    cart.forEach((p) => qty = qty + p["qty"]);
    // cart.refresh();

    return qty;
  }

  addToCart(input) {
    var index = cart.indexWhere((p) => p["id"] == input["id"]);
    print(index);
    if (index == -1) {
      input["total"] = input["qty"] * input["price"];
      cart.add(input);
    } else {
      cart[index]["total"] = cart[index]["total"] + cart[index]["price"];
      cart[index]["qty"] = cart[index]["qty"] + 1;
    }
    cart.refresh();
    print(cart);
  }

  removeFromCart(input) {
    var index = cart.indexWhere((p) => p["id"] == input["id"]);
    if (index == -1) {
      print("no product is available to delete");
    } else {
      if (cart[index]["qty"] == 1) {
        cart.removeAt(index);
      } else {
        cart[index]["total"] = cart[index]["total"] - cart[index]["price"];
        cart[index]["qty"] = cart[index]["qty"] - 1;
      }
      cart.refresh();
      print(cart);
    }
  }
}
