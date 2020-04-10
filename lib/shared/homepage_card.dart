import 'package:fitnesssful/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

class CustomCard extends StatelessWidget {
  final Color color;
  final String data;
  final IconData icon;
  final String label;
  final String image;
  CustomCard({this.color, this.data, this.icon, this.image,this.label});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: kwidth(context),
        height: kheight(context) / 6,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height:20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Transform.rotate(
                        angle: pi / 2,
                        child: FaIcon(
                          icon,
                          size: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(label, style: TextStyle(color: Colors.white , fontSize: 23 , fontWeight: FontWeight.w300))
                    ],
                  ),
                 SizedBox(
                   height:8
                 ),
                  Text(
                    data,
                    style: kHomePageCard,
                  )
                ],
              ),
            ),
            Container(width:kwidth(context) * 0.4 ,
              child: Center(child: FaIcon(icon , color: Colors.white, size: kwidth(context) * 0.25
                ,))
            )
          ],
        ),
      ),
    );
  }
}
