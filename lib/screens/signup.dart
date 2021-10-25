import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_ui/controllers/authentication.dart';

class SignUpScreen extends StatelessWidget {
  AuthController _auth = AuthController();
  TextEditingController _nameContoller = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();

  TextEditingController _passwordContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Create an account',
          style: TextStyle(color: Colors.green),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.green),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Image.asset(
                  "assets/images/logo.png",
                  height: 120,
                  width: 120,
                ),
                SizedBox(height: 20),
                Image.asset(
                  "assets/images/Groceterialogo.png",
                  height: 70,
                  width: 120,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _nameContoller,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: InputBorder.none,
                    labelText: "Full Name",
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _emailContoller,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: InputBorder.none,
                    labelText: "Email",
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _passwordContoller,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: InputBorder.none,
                    labelText: "Password",
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    child: Text("Sign Up"),
                    onPressed: () {
                      _auth.register(_nameContoller.text, _emailContoller.text,
                          _passwordContoller.text);
                    },
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  child: TextButton(
                    child: Text('Already Have an Account?'),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          child: Image.asset("assets/images/fb-icon.png",
                              height: 34),
                          onTap: () {}),
                      SizedBox(width: 25),
                      GestureDetector(
                        child: Image.asset("assets/images/google-icon.png",
                            height: 34),
                        onTap: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
