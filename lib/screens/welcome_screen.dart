import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
//      upperBound: 100, //Curves range from 0-1 so upperBound can't be greater than 1
    );

//    animation =
//        CurvedAnimation(parent: animationController, curve: Curves.easeIn);

    animation = ColorTween(begin: Colors.red, end: Colors.blue)
        .animate(animationController);
    animationController.forward();

//    //Loops through the animation forward and reverse basing on the status changes at each of forward() and reverse() methods
//    animation.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        //forward() animation ends with completed status
//        animationController.reverse(from: 1.0);
//      } else if (status == AnimationStatus.dismissed) {
//        //reverse() animation ends with dismissed status
//        animationController.forward();
//      }
//      print(status);
//    });

    animationController.addListener(() {
      //We don't have to add anything to the state as value is changing anyways in addListener
      setState(() {});
    });
  }

  @override
  void dispose() {
    //animation doesn't dispose even if we change screens unless we manually dispose it.
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                TyperAnimatedTextKit(
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: "Log In",
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              color: Colors.lightBlueAccent,
            ),
            RoundedButton(
              title: "Register",
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
