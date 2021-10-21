import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_ui/controllers/address.dart';
import 'package:learning_ui/screens/edit_address.dart';

class ManageAddress extends StatelessWidget {
  AddressController _addressController = Get.put(AddressController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Address"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(() => EditAddress(canEdit: false, address: {}));
        },
      ),
      body: Obx(
        () => ListView.builder(
            itemCount: _addressController.addresses.length,
            itemBuilder: (bc, index) {
              return ListTile(
                  title: Text("${_addressController.addresses[index]["tag"]}"),
                  subtitle:
                      Text("${_addressController.addresses[index]["address"]}"),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.edit_outlined,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      Get.to(() => EditAddress(
                            canEdit: true,
                            address: _addressController.addresses[index],
                          ));
                    },
                  ));
            }),
      ),
    );
  }
}
