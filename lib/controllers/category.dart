import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  var categories = [].obs;

  @override
  void onInit() {
    super.onInit();
    this.fetchCategories();
  }

  fetchCategories() {
    _db.collection("categories").snapshots().listen((event) {
      categories.clear();
      var _tmp = [];
      event.docs.forEach((element) {
        _tmp.add({"id": element.id, "title": element.data()["title"]});
      });
      categories.assignAll(_tmp);
    });
  }

  updateCategory(id, obj) {
    _db.collection("categories").doc(id).update(obj).then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }

  add(obj) {
    _db.collection("categories").add(obj).then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }

  delete(id) {
    _db.collection("categories").doc(id).delete().then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }
}
