import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserServices{
  Firestore  database = Firestore.instance;
  String ref = "users";

  createUser(String uid, Map value){
    Firestore.instance.collection("users")
        .document(uid)
        .setData(value);
    Fluttertoast.showToast(msg: "Account created!");

  }

}