import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Text(
      'Dins',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}

InputDecoration textFieldImportDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.white54,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  );
}

TextStyle simpleTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 20,
  );
}

TextStyle mediumTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
}

Container signInButton(BuildContext context, String buttonName) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(vertical: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      gradient: LinearGradient(
        colors: [
          Colors.green,
          Colors.grey,
        ],
      ),
    ),
    width: MediaQuery.of(context).size.width,
    child: Text(
      buttonName,
      style: simpleTextStyle(),
    ),
  );
}
