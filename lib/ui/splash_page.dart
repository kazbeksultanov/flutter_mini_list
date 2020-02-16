import 'package:flutter/material.dart';
import 'package:flutter_mini_list/data/repository.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    setUP(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            "Splash Screen",
            style: TextStyle(color: Colors.cyan, fontSize: 36, shadows: [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 5,
                offset: Offset.zero,
                blurRadius: 5,
              )
            ]),
          ),
        ),
      ),
    );
  }
}


