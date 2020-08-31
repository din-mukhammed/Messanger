import 'package:flutter/material.dart';
import 'package:messangerApp/helper/functions.dart';
import 'package:messangerApp/services/auth.dart';
import 'package:messangerApp/services/database.dart';
import 'package:messangerApp/widgets/widget.dart';

import 'chatRoomsScreen.dart';

class SignUp extends StatefulWidget {
  final Function toggle;

  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTED = new TextEditingController();
  TextEditingController emailTED = new TextEditingController();
  TextEditingController passwordTED = new TextEditingController();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  HelperFunctions helperFunctions = new HelperFunctions();

  signingUP() {
    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "name": userNameTED.text,
        "email": emailTED.text
      };
      HelperFunctions.saveUserEmailSharedPreference(emailTED.text);
      HelperFunctions.saveUserNameSharedPreference(userNameTED.text);

      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmailAndPassword(emailTED.text, passwordTED.text)
          .then((value) {
        dataBaseMethods.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ChatRoom()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (val) {
                                return val.isEmpty || val.length < 4
                                    ? "Invalid login"
                                    : null;
                              },
                              controller: userNameTED,
                              style: simpleTextStyle(),
                              decoration: textFieldImportDecoration("username"),
                            ),
                            TextFormField(
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)
                                    ? null
                                    : "Invalid email";
                              },
                              controller: emailTED,
                              style: simpleTextStyle(),
                              decoration: textFieldImportDecoration("email"),
                            ),
                            TextFormField(
                              validator: (val) {
                                return val.length > 6
                                    ? null
                                    : "Password cann\'t be less than 6 symbols.";
                              },
                              obscureText: true,
                              controller: passwordTED,
                              style: simpleTextStyle(),
                              decoration: textFieldImportDecoration("password"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            "Forgot Password",
                            style: simpleTextStyle(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                          onTap: () {
                            signingUP();
                          },
                          child: signInButton(context, "Sign Up")),
                      SizedBox(height: 20),
                      signInButton(context, "Sign Up with Google"),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: mediumTextStyle(),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggle();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(" SignIn Now",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      decoration: TextDecoration.underline)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
