import 'package:fitnesssful/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitnesssful/models/user.dart';
import 'package:fitnesssful/services/database.dart';
import 'package:toast/toast.dart';

class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  int index = 0;

  String buttonText = 'Next';
  String ans1 = '';
  String ans2 = ''; //  add total number of answers
  List<Key> _key = [
    GlobalKey(),
    GlobalKey(),
  ]; //  add number of keys according to numbr of questions

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final db = DatabaseService(uid: user.uid);
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          ),
        ),
        height: kheight(context) * 0.4,
        width: kwidth(context) * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Please answer a few questions first!',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 23.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 5),
            IndexedStack(
              index: index,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Question data 1',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        decoration: textInputDecoration,
                        key: _key[0],
                        onChanged: (value) {
                          ans1 = value;
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'Question data 2',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextField(
                        decoration: textInputDecoration,
                        key: _key[1],
                        onChanged: (value) {
                          ans2 = value;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: kwidth(context),
                height: 40.0,
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.pink[400],
                  onPressed: () async {
                    if (index < 1) {
                      // change this to total number of questions -1
                      // example number of questions = 6 , this value = 5
                      setState(() {
                        index++;
                      });
                    } else if (index == 1) {
                      // same value here
                      setState(() {
                        buttonText = 'Finish';
                      });
                    } else
                      setState(() {
                        index = 0;
                      });

                    if (buttonText == 'Finish') {
                      await db.updateQuestion(ans1, ans2);
                      Toast.show('Please Wait', context);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                      child: Text(
                    buttonText,
                    style: TextStyle(fontSize: 18.0),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
