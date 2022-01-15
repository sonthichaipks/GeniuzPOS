import 'package:flutter/material.dart';

class CsiStyle {
  Color darkColor = Colors.orange[300];
  Color primaryColor = Colors.orange[300];
  Color deleteColor = Colors.red;
  Color backgroundColor = Colors.orangeAccent;

  Container showLogo() {
    return Container(
      width: 120.0,
      child: Image.asset(
        'assets/logo.png',
        height: 100,
        width: 100,
      ),
    );
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 20.0,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold),
      );

  Text showTitleHeader(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 16.0,
            // color: Colors.blue.shade900,
            fontWeight: FontWeight.bold),
      );

  Text showTitleText(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );

  Text showHeaderText(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 11.0,
          color: Colors.black,
          // fontWeight: FontWeight.bold,
        ),
      );

  Text showTitleTextSmall(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 10.0,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      );

  Container showPowerPOS() {
    return Container(
      width: 180.0,
      child: Image.asset('assets/logo.png'),
    );
  }

  static titleStyle(Color color) {}
}
