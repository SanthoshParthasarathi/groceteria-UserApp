import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_ui/controllers/profile.dart';
import 'package:learning_ui/screens/edit_profile.dart';
import 'package:learning_ui/screens/manage_address.dart';
import 'package:learning_ui/screens/orders.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var isSwitched = false;
  ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("${_profileController.userObj["name"]} name");
    print("${_profileController.userObj["address"]} add");
    print("${_profileController.userObj["mobile"]} mobile");
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
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile1.jpg"),
            ),
            title: Text('Santhosh Parthasarathi'),
            subtitle: Text('+8015456303'),
            trailing: TextButton(
              child: Text('Edit'),
              onPressed: () {
                Get.to(() => EditProfile());
              },
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.notifications_active_outlined,
              color: Colors.green,
            ),
            title: Text("Notifications"),
            subtitle: Text("Turn On / Off Notifications"),
            trailing: Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                  print(isSwitched);
                });
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
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
