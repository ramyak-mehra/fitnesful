import 'package:fitnesssful/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:fitnesssful/shared/constants.dart';

class Calorie extends StatefulWidget {
  @override
  _CalorieState createState() => _CalorieState();
}

class _CalorieState extends State<Calorie> {
  String calories = '';
  String unit = '';
  String gram = '';
  String name = '';
  String search = '';
  request() async {
    String url = 'https://trackapi.nutritionix.com/v2/natural/nutrients';
    Map<String, String> headers = {
      "Content-type": "application/json",
      "x-app-id": "0a3b7f22",
      "x-app-key": "8815c9a9b559b1138e4d2f9b567cef02"
    };
    Map json1 = {"query": search};
    var body = json.encode(json1);
    http.Response response = await http.post(url, body: body, headers: headers);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var decodeJson = json.decode(response.body);

      calories = decodeJson['foods'][0]['nf_calories'].toString();
      unit = decodeJson['foods'][0]['serving_unit'].toString();
      gram = decodeJson['foods'][0]['serving_weight_grams'].toString();
      name = decodeJson['foods'][0]['food_name'].toString();
      setState(() {});
      return true;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Center(
                child: Text(
              'Search For Any Item ',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 33,
                  fontWeight: FontWeight.w500),
            )),
            SizedBox(
              height: 50.0,
            ),
            Container(
              width: kwidth(context),
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: kwidth(context) * 0.8,
                      child: TextField(
                        decoration: textInputDecoration,
                        onChanged: (value) {
                          search = value;
                          setState(() {});
                        },
                        onSubmitted: (value) {
                          setState(() {});
                          search = value;
                        },
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () async {
                          calories = '';
                          unit = '';
                          gram = '';
                          name = '';
                          //  search = '';
                          setState(() {});
                          Toast.show(" Please Wait", context,
                              duration: Toast.LENGTH_LONG);

                          bool result = await request();

                          if (result) {
                          } else {
                            Toast.show(" Please Try Again", context);
                          }
                        })
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              width: kwidth(context),
              child: Card(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Item Name: ' + name ?? '',
                      style: calorie,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Item Servings: ' + unit ?? '',
                      style: calorie,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Calories: ' + calories ?? '', style: calorie),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Serving Weight(grams): ' + gram ?? '',
                        style: calorie),
                  ),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
