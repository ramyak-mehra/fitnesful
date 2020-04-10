import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),

  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);

const TextStyle kHomePageCard =
    TextStyle(fontSize: 40.0, color: Colors.white, fontWeight: FontWeight.w600);

TextStyle kHomePageHeading = TextStyle(fontSize: 50.0, color: Colors.grey[400]);

double kheight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double kwidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
