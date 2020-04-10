import 'package:fitnesssful/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fitnesssful/models/user.dart';


class SignupOnePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    //  final db = DatabaseService(uid: user.uid);

    return Scaffold(
      body: Container(
        color: Colors.blue.shade100,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            CircleAvatar(
              child: Image.asset(
                'lib/assets/train.jpg',
                color: Colors.blue.shade100,
                colorBlendMode: BlendMode.darken,
              ),
              maxRadius: 50,
              // backgroundColor: Colors.blue,
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: RoundedDiagonalPathClipper(),
                    child: Container(
                      height: 400,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 90.0,
                          ),
                          Container(
                            child: Divider(
                              color: Colors.blue.shade400,
                            ),
                            padding: EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 10.0),
                          ),
                          RaisedButton(
                            onPressed: () async {
                              User result = await _auth.signInWithGoogle();
                              Navigator.popAndPushNamed(context, '/home');
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Text("Sign In Via Google",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 23)),
                            color: Colors.blue,
                          ),
                          Container(
                            child: Divider(
                              color: Colors.blue.shade400,
                            ),
                            padding: EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 10.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 40.0,
                        backgroundColor: Colors.blue.shade600,
                        child: Icon(Icons.person),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
