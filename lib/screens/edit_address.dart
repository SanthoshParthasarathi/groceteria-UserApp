import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:learning_ui/controllers/address.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

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

  double _lat = 13.0827;
  double _lng = 80.2707;

  Completer<GoogleMapController> _controller = Completer();
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  CameraPosition _currentPosition;

  generateAddress(lat, lng) async {
    final coordinates = new Coordinates(lat, lng);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    _fullAddressController.text = address.first.addressLine.toString();
    _pinCodeController.text = address.first.postalCode.toString();
  }

  fetchMyLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    await location.getLocation().then((res) async {
      final GoogleMapController controller = await _controller.future;
      final _position = CameraPosition(
        target: LatLng(res.latitude, res.longitude),
        zoom: 12,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(_position));
      setState(() {
        _lat = res.latitude;
        _lng = res.longitude;
      });
      generateAddress(_lat, _lng);
    });
  }

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
              padding: EdgeInsets.only(top: 18, left: 18, right: 18),
              height: 280,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(_lat, _lng),
                  zoom: 12,
                ),
                onMapCreated: (res) {
                  _controller.complete(res);
                  fetchMyLocation();
                },
                markers: {
                  Marker(
                      markerId: MarkerId("current"),
                      position: LatLng(_lat, _lng),
                      draggable: true,
                      onDragEnd: (latlng) {
                        generateAddress(latlng.latitude, latlng.longitude);
                      })
                },
              ),
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
