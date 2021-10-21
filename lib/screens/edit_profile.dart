import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_ui/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: must_be_immutable
class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _db = FirebaseFirestore.instance;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();

  var _profileImage = "http://placehold.it/120x120";

  logout() {
    _auth.signOut().then((value) {
      Get.offAll(() => LoginScreen());
    }).catchError((e) {
      print(e);
    });
  }

  readStoreDetails() {
    _db.collection("settings").doc("store").snapshots().listen((value) {
      print(value);
      print(value.id);
      print(value.data());
      setState(() {
        _nameController.text = value.data()["name"];
        _emailController.text = value.data()["email"];
        _mobileController.text = value.data()["mobile"];
        _addressController.text = value.data()["address"];
        _profileImage = value.data()["imageURL"];
      });
    });
  }

  updateStoreDetails() {
    _db.collection("settings").doc("store").update({
      "address": _addressController.text,
      "name": _nameController.text,
      "mobile": _mobileController.text,
      "email": _emailController.text
    }).then((value) {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readStoreDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Edit Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  uploadProfileImage();
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_profileImage),
                  radius: 65,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: InputBorder.none,
                  labelText: "Full Name",
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: InputBorder.none,
                  labelText: "Email",
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _mobileController,
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: InputBorder.none,
                  labelText: "Mobile Number",
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _addressController,
                maxLines: 4,
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: InputBorder.none,
                  labelText: "Store Address",
                ),
              ),
              SizedBox(height: 25),
              Container(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  child: Text("Save Changes"),
                  onPressed: () {
                    updateStoreDetails();
                    Get.back();
                  },
                ),
              ),
              SizedBox(height: 15),
              Container(
                child: TextButton(
                  child: Text('Logout from this account'),
                  onPressed: () {
                    logout();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
