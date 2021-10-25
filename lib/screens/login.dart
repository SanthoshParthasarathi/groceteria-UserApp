// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_ui/controllers/authentication.dart';
import 'package:learning_ui/screens/signup.dart';
// import 'package:learning_ui/screens/tabs.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  // FirebaseAuth _auth = FirebaseAuth.instance;

  AuthController _auth = AuthController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // login() {
  //   var emailText = (_emailController.text).trim().toLowerCase();
  //   var passwordText = _passwordController.text;
  //   _auth
  //       .signInWithEmailAndPassword(email: emailText, password: passwordText)
  //       .then((value) {
  //     print(value);
  //     Get.offAll(() => TabsScreen());
  //   }).catchError((e) {
  //     print(e);
  //     Get.showSnackbar(GetBar(
  //       message: "${e.toString()}",
  //       duration: Duration(seconds: 3),
  //     ));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'User Login',
          style: TextStyle(color: Colors.green),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        // leading: new IconButton(
        //   icon: new Icon(Icons.arrow_back_ios_new, color: Colors.green),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                Image.asset(
                  "assets/images/logo.png",
                  height: 120,
                  width: 120,
                ),
                SizedBox(height: 10),
                Image.asset(
                  "assets/images/Groceterialogo.png",
                  height: 70,
                  width: 120,
                ),
                SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.emailAddress,
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
                  controller: _passwordController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: InputBorder.none,
                    labelText: "Password",
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    child: Text("Login"),
                    onPressed: () {
                      _auth.login(
                          _emailController.text, _passwordController.text);
                    },
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  child: TextButton(
                    child: Text('Create a new account'),
                    onPressed: () {
                      Get.to(() => SignUpScreen());
                    },
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent, elevation: 0),
                        child: Image.asset("assets/images/fb-icon.png",
                            height: 32),
                        onPressed: () {
                          // _auth.signInWithGoogle();
                        },
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent, elevation: 0),
                        child: Image.asset("assets/images/google-icon.png",
                            height: 32),
                        onPressed: () {
                          _auth.signInWithGoogle();
                        },
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
