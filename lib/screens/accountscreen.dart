import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_ui/controllers/profile.dart';
import 'package:learning_ui/screens/edit_profile.dart';
import 'package:learning_ui/screens/manage_address.dart';
import 'package:learning_ui/screens/orders.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AccountScreen extends StatelessWidget {
  var isSwitched = false;
  ProfileController _profileController = Get.put(ProfileController());
  var _profileImage = "http://placehold.it/120x120";

  registerPushNotification() {
    FirebaseMessaging.instance.getToken().then((token) {
      print(token);
      _profileController.updateProfile({"pushToken": token});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Account",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: ListView(
        children: [
          Obx(
            () => ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    _profileController.userObj["imageURL"] == null
                        ? _profileImage
                        : _profileController.userObj["imageURL"]),
              ),
              title: Text("${_profileController.userObj["name"]}"),
              subtitle: Text("${_profileController.userObj["mobile"]}"),
              trailing: TextButton(
                child: Text('Edit'),
                onPressed: () {
                  Get.to(() => EditProfile());
                },
              ),
            ),
          ),
          Obx(
            () => ListTile(
              leading: Icon(Icons.notifications_active_outlined,
                  color: Colors.green),
              title: Text("Notifications"),
              subtitle: Text("Turn on/off Notification"),
              trailing: Switch(
                onChanged: (res) {
                  if (res) {
                    registerPushNotification();
                  } else {
                    _profileController.updateProfile({"pushToken": null});
                  }
                },
                value: _profileController.userObj["pushToken"] != null
                    ? true
                    : false,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.green,
            ),
            title: Text("My Orders"),
            subtitle: Text("Manage orders"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.green,
            ),
            onTap: () {
              Get.to(() => MyOrdersScreen());
            },
          ),
          ListTile(
            onTap: () {
              Get.to(() => ManageAddress());
            },
            leading: Icon(
              Icons.location_on,
              color: Colors.green,
            ),
            title: Text("My Address"),
            subtitle: Text("Manage Delivery Address"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
