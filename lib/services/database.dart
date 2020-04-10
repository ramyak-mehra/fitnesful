import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
//collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('Users');

//update Database
  Future updateUserData(String name, String email) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'email': email,
      'uid': uid,
      'dietPlan': '', // add more ansewers and change the data accoirdingly
      'formFilled': false,
      'ques1': 'ans1',
      'ques2': 'ans2',
    });
  }

  Future updateQuestion(
    String ans1,
    String ans2, // add more ansewers and change the data accoirdingly
  ) async {
    return await userCollection.document(uid).updateData({
      'formFilled': true,
      'ques1': ans1,
      'ques2': ans2,
    });
  }

  Future updateValues() async {}

//get userData stream
  Stream get dietPlan {
    return userCollection.document(uid).snapshots();
  }
}

//Future updateUserData(String name, String email, String userID) async {
//  return await Firestore.instance.collection('Users').document(userID).setData({
//    'name': name,
//    'email': email,
//    'uid': userID,
//    'dietPlan': '',
//    'formFilled': false
//  });
//}
