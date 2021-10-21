import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var userObj = {}.obs;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  readStoreDetails() {
    _db.collection("settings").doc("store").snapshots().listen((value) {
      if (value.data() != null) {
        print(value);
        print(value.id);
        print(value.data());
        userObj.assignAll({"id": value.id, ...value.data()});
      }
    });
  }

  updateStoreDetails(obj) {
    _db.collection("settings").doc("store").update(obj).then((value) {
      print("updated those values");
    }).catchError((e) {
      print(e);
    });
  }

  uploadProfileImage() async {
    var picker = ImagePicker();
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile.path.length != 0) {
      File image = File(pickedFile.path);
      FirebaseStorage _storage = FirebaseStorage.instance;

      _storage
          .ref()
          .child("store")
          .child("storeImage")
          .putFile(image)
          .then((value) {
        print(value);
        value.ref.getDownloadURL().then((url) {
          print("Uploaded Url - " + url);
          _db
              .collection("settings")
              .doc("store")
              .update({"imageURL": url}).then((value) {
            print("updated those values");
          }).catchError((e) {
            print(e);
          });
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      print("no file is chosen");
    }
  }
}
