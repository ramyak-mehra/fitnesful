import 'package:fitnesssful/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fitnesssful/models/user.dart';
import 'package:provider/provider.dart';

class DietPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder(
        stream: DatabaseService(uid: user.uid).dietPlan,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userDocument = snapshot.data;
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 50.0,
                      ),
                      Center(
                          child: Text(
                        'Diet Plan To Follow',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 33,
                            fontWeight: FontWeight.w500),
                      )),
                      SizedBox(
                        height: 50.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: userDocument['dietPlan'] == ''
                            ? CircularProgressIndicator()
                            : Text(
                                userDocument['dietPlan'] ?? 'Please Wait',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 23),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          }
        });
  }
}
