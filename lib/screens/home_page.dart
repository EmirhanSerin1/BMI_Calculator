import 'package:flutter/material.dart';
import 'package:flutter_bmi_calculator/core/constants/colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: mainColor,
        child: SafeArea(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: sideColor,
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 4,
                  
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 4,
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
