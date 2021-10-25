import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_ui/controllers/authentication.dart';
import 'package:learning_ui/controllers/profile.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  static AuthController _authController = Get.put(AuthController());

  static ProfileController _profileController = Get.put(ProfileController());

  TextEditingController _nameController =
      TextEditingController(text: _profileController.userObj["name"]);
  TextEditingController _emailController =
      TextEditingController(text: _profileController.userObj["email"]);
  TextEditingController _mobileController =
      TextEditingController(text: _profileController.userObj["mobile"]);
  TextEditingController _addressController =
      TextEditingController(text: _profileController.userObj["address"]);

  var _profileImage = "http://placehold.it/120x120";

  // logout() {
  //   _auth.signOut().then((value) {
  //     Get.offAll(() => LoginScreen());
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  // readStoreDetails() {
  //   _db.collection("settings").doc("store").snapshots().listen((value) {
  //     print(value);
  //     print(value.id);
  //     print(value.data());
  //     setState(() {
  //       _nameController.text = value.data()["name"];
  //       _emailController.text = value.data()["email"];
  //       _mobileController.text = value.data()["mobile"];
  //       _addressController.text = value.data()["address"];
  //       _profileImage = value.data()["imageURL"];
  //     });
  //   });
  // }

  // updateStoreDetails() {
  //   _db.collection("settings").doc("store").update({
  //     "address": _addressController.text,
  //     "name": _nameController.text,
  //     "mobile": _mobileController.text,
  //     "email": _emailController.text
  //   }).then((value) {
  //     print("updated those values");
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  // uploadProfileImage() async {
  //   var picker = ImagePicker();
  //   var pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   if (pickedFile.path.length != 0) {
  //     File image = File(pickedFile.path);
  //     FirebaseStorage _storage = FirebaseStorage.instance;

  //     _storage
  //         .ref()
  //         .child("store")
  //         .child("storeImage")
  //         .putFile(image)
  //         .then((value) {
  //       print(value);
  //       value.ref.getDownloadURL().then((url) {
  //         print("Uploaded Url - " + url);
  //         _db
  //             .collection("settings")
  //             .doc("store")
  //             .update({"imageURL": url}).then((value) {
  //           print("updated those values");
  //         }).catchError((e) {
  //           print(e);
  //         });
  //       });
  //     }).catchError((e) {
  //       print(e);
  //     });
  //   } else {
  //     print("no file is chosen");
  //   }
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   readStoreDetails();
  // }

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
                  _profileController.uploadProfileImage();
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      _profileController.userObj["imageURL"] == null
                          ? _profileImage
                          : _profileController.userObj["imageURL"]),
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
                    _profileController.updateProfile({
                      "mobile": _mobileController.text,
                      "email": _emailController.text,
                      "name": _nameController.text,
                      "address": _addressController.text
                    });
                    Get.back();
                  },
                ),
              ),
              SizedBox(height: 15),
              Container(
                child: TextButton(
                  child: Text('Logout from this account'),
                  onPressed: () {
                    _authController.logout();
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
