import 'package:fitnesssful/screens/home/diet_plan.dart';
import 'package:fitnesssful/screens/wrapper.dart';
import 'package:fitnesssful/services/auth.dart';
import 'package:fitnesssful/services/fitData.dart';
import 'package:fitnesssful/shared/constants.dart';
import 'package:fitnesssful/shared/homepage_card.dart';
import 'package:fitnesssful/shared/questions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:fitnesssful/models/user.dart';
import 'package:fitnesssful/services/database.dart';
import 'package:fitnesssful/screens/home/calories.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String steps = ' ';
  String energy = ' ';
  bool formFilled;

  void readData() async {
    await Permission.sensors.request();
    await Permission.location.request();
    await Permission.activityRecognition.request();
    steps = await readSteps();
    energy = await readEnergy();
    setState(() {});
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final db = DatabaseService(uid: user.uid);
    AuthService _auth = AuthService();

    return StreamBuilder(
        stream: db.userCollection.document(user.uid).snapshots(),
        builder: (context, snapshot) {
          return Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: kwidth(context),
                  height: 50.0,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.pink[400],
                    onPressed: () {
                      // formFilled = snapshot.data['formFilled'];
                      // if (snapshot.hasData) {
                      //   if (formFilled == false) {
                      //     showDialog(
                      //         context: context,
                      //         barrierDismissible: true,
                      //         builder: (BuildContext context) {
                      //           return Dialog(
                      //             child: Questions(),
                      //             elevation: 5.0,
                      //           );
                      //         });
                      //   } else {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (BuildContext context) =>
                      //                 DietPlan()));
                      //   }
                      // } else {
                      //   showDialog(
                      //       context: context,
                      //       barrierDismissible: true,
                      //       builder: (BuildContext context) {
                      //         return Dialog(
                      //           child: Questions(),
                      //           elevation: 5.0,
                      //         );
                      //       });
                      // }

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext contexet) => Calorie()));
                    },
                    child: Container(
                        child: Text(
                      'Search Calories in Food Item',
                    )),
                  )),
            ),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Container(
                        child: GestureDetector(
                            onTap: () async {
                              await _auth.googleSignOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Wrapper()));
                            },
                            child: Text(
                              'logout',
                              style: TextStyle(
                                  color: Colors.lightBlue, fontSize: 20),
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Today',
                    style: kHomePageHeading,
                  ),
                ),
                SizedBox(height: 80.0),
                steps == ''
                    ? CircularProgressIndicator()
                    : CustomCard(
                        color: Colors.blue[300],
                        data: steps ?? '',
                        label: 'Foot Steps',
                        image: 'lib/assets/calories.jpg',
                        icon: FontAwesomeIcons.shoePrints,
                      ),
                energy == ''
                    ? CircularProgressIndicator()
                    : CustomCard(
                        image: 'lib/assets/calories.jpg',
                        color: Colors.orange[300],
                        data: energy ?? '',
                        label: 'Enery Burn',
                        icon: FontAwesomeIcons.dumbbell,
                      ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Container(
                    height: 40.0,
                    width: 120,
                    child: RaisedButton(
                        textColor: Colors.white,
                        child: Text('Refresh'),
                        color: Colors.purple[300],
                        onPressed: () {
                          readData();
                          setState(() {});
                        }),
                  ),
                )
              ],
            ))),
          );
        });
  }
}
