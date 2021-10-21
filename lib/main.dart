import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_ui/screens/validate.dart';
import '../screens/welcomescreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green,
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -0.4))
        .animate(_animationController);

    _animationController.forward().whenComplete(() {
      // put here the stuff you wanna do when animation completed!
    });
    // getprefs();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _animationController.dispose();
    super.dispose();
  }

  //  getprefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var status = prefs.getBool('isLoggedIn') ?? false;
  //   print(status);
  //   var employeeId;
  //   runApp(MaterialApp(home: status == true? DashboardHomePage() : HomePage()));
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: AnimatedSplashScreen(
        splash: Image.asset(
          "assets/images/app-icon.png",
          width: 500.0,
          height: 500.0,
        ),
        nextScreen: ValidateScreen(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.tealAccent[100],
        duration: 3000,
      ),
    ));
  }
}
