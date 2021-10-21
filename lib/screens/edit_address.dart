import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_ui/controllers/address.dart';

class EditAddress extends StatefulWidget {
  bool canEdit;
  var address;

  EditAddress({this.canEdit, this.address});
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  AddressController _addressController = Get.put(AddressController());
  TextEditingController _tagController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _fullAddressController = TextEditingController();
  TextEditingController _pinCodeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tagController.text = widget.address["tag"];
    _nameController.text = widget.address["name"];
    _mobileController.text = widget.address["mobile"];
    _fullAddressController.text = widget.address["address"];
    _pinCodeController.text = widget.address["pincode"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.canEdit ? "Edit" : "Add"} Address"),
        centerTitle: true,
        actions: [
          widget.canEdit
              ? IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _addressController.deleteAddress(widget.address["id"]);
                  },
                )
              : Container()
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.asset("assets/images/map.png"),
            ),
            Container(
              padding: EdgeInsets.all(18),
              child: Column(
                children: [
                  TextField(
                    controller: _tagController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: InputBorder.none,
                      labelText: "Tag (Eg- Home, Office)",
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: InputBorder.none,
                      labelText: "Name",
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _mobileController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: InputBorder.none,
                      labelText: "Mobile Number",
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _fullAddressController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: InputBorder.none,
                      labelText: "Full Address",
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _pinCodeController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: InputBorder.none,
                      labelText: "Pincode",
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      child: Text("Save Changes"),
                      onPressed: () {
                        widget.canEdit
                            ? _addressController
                                .updateAddress(widget.address["id"], {
                                "tag": _tagController.text,
                                "name": _nameController.text,
                                "mobile": _mobileController.text,
                                "address": _fullAddressController.text,
                                "pincode": _pinCodeController.text
                              })
                            : _addressController.addAddress({
                                "tag": _tagController.text,
                                "name": _nameController.text,
                                "mobile": _mobileController.text,
                                "address": _fullAddressController.text,
                                "pincode": _pinCodeController.text
                              });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
