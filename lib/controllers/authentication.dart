import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learning_ui/controllers/profile.dart';
import 'package:learning_ui/screens/login.dart';
import 'package:learning_ui/screens/tabs.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:store/controller/profile.dart';
// import 'package:store/screens/login.dart';
// import 'package:store/screens/tabs.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  ProfileController _profileController = Get.put(ProfileController());
  FirebaseFirestore _db = FirebaseFirestore.instance;
  var isUserLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    validate();
  }

  validate() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        isUserLoggedIn.value = true;
        _profileController.readStoreDetails();
        print(_profileController.readStoreDetails());
      } else {
        isUserLoggedIn.value = false;
      }
    });
  }

  login(email, password) {
    email = email.trim().toLowerCase();
    password = password;
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value);
      Get.offAll(() => TabsScreen());
    }).catchError((e) {
      print(e);
      Get.showSnackbar(GetBar(
        message: "${e.toString()}",
        duration: Duration(seconds: 3),
      ));
      // return Fluttertoast.showToast(
      //     msg: "${e.toString()}",
      //     backgroundColor: Colors.grey[350],
      //     toastLength: Toast.LENGTH_SHORT,
      //     fontSize: 16.0,
      //     textColor: Colors.black,
      //     gravity: ToastGravity.BOTTOM);
    });
  }

  register(name, email, password) {
    email = email.trim().toLowerCase();
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((res) {
      var userId = res.user.uid;

      _db.collection("accounts").doc(userId).set({
        "name": name,
        "email": email,
        "createdAt": FieldValue.serverTimestamp(),
        "imageURL": "http://placehold.it/120x120"
      }).then((value) {
        Get.offAll(TabsScreen());
      }).catchError((e) {
        print(e);
      });
    }).catchError((e) {
      print(e);
    });
  }

  logout() {
    _auth.signOut().then((value) {
      Get.offAll(() => LoginScreen());
    }).catchError((e) {
      print(e);
    });
  }
}
