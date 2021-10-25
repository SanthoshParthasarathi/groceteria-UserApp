import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var userObj = {}.obs;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  // @override
  // onInit() {
  //   super.onInit();
  //   getUserDetail(userObj);
  // }

  getUserDetail(id) {
    _db.collection("accounts").doc(id).snapshots().listen((res) {
      if (res.data() != null) {
        userObj.assignAll({"id": res.id, ...res.data()});
      }
    });
  }

  updateProfile(obj) {
    _db
        .collection("accounts")
        .doc(_auth.currentUser.uid)
        .update(obj)
        .then((value) {
      print("Updated");
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
          .child("accounts")
          .child(_auth.currentUser.uid)
          .child("profile")
          .putFile(image)
          .then((res) {
        print(res);
        res.ref.getDownloadURL().then((url) {
          print("uploaded URL" + url);
          _db.collection("accounts").doc(_auth.currentUser.uid).update({
            "imageURL": url,
          }).then((value) {
            print("Updated");
          }).catchError((e) {
            print(e);
          });
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      print("No file picked");
    }
  }
}
