import 'package:flutter/material.dart';
import 'package:flutterapp2/pages/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutterapp2/pages/home.dart';
import 'package:flutterapp2/db/users.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();
  SharedPreferences preferences; //store some values of the app
  UserServices userServices = UserServices();
  bool loading = false;
  String gender;
  String groupValue = "male";

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/back.jpg',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.8),
          ),


//          EMAIL
          Padding(
            padding: EdgeInsets.only(top:10),
            child: Center(
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[

                    Container(
                      alignment: Alignment.center,
                      child: Image.asset('images/lg.png'),
                      width: 200,
                      height: 170,
                    ),
                    //                  NAME
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.7),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12,0,0,0),
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Name",
                              icon: Icon(Icons.person_outline),
                            ),
                            style: TextStyle(fontSize: 18),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Name cannot be empty';
                              }else
                                return null;
                            },
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.7),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12,0,0,0),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              icon: Icon(Icons.alternate_email),
                            ),
                            style: TextStyle(fontSize: 18),
                            validator: (value) {
                              if (value.isEmpty) {
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value))
                                  return 'Please make sure your email address is valid';
                                else
                                  return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),

//                  PASSWORD
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.7),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12,0,0,0),
                          child: TextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              icon: Icon(Icons.lock_outline),
                            ),
                            style: TextStyle(fontSize: 18),
                            validator: (value) {
                              if (value.isEmpty || value.length<6) {
                                return 'Password is invalid';
                              }else
                                return null;
                            },
                          ),
                        ),
                      ),
                    ),

//                  C PASSWORD
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.7),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12,0,0,0),
                          child: TextFormField(
                            obscureText: true,
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Confirm Password",
                              icon: Icon(Icons.lock_outline),
                            ),
                            style: TextStyle(fontSize: 18,),
                            validator: (value) {
                              if (value.isEmpty || value.compareTo(_passwordController.text)!=0) {
                                return 'Passwords do not match';
                              }else
                                return null;
                            },
                          ),
                        ),
                      ),
                    ),


//                  BUTTON
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.blue.withOpacity(0.9),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12,0,12,0),
                          child: MaterialButton(
                            onPressed: () async {
                              ValidateForm();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                               // Icon(Icons.email, color: Colors.white.withOpacity(0.9),size: 30,),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('Sign up',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white,
                                        fontSize: 17),),
                                ),

                              ],
                            ),

                          ),
                        ),
                      ),
                    ),


                  ],),
                ),
              ),
            ),
          ),


          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                color: Colors.white.withOpacity(0.9),
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
          ),

        ],
      ),

    );
  }

  Future ValidateForm() async{
    FormState formState = formkey.currentState;
    FirebaseUser user = await firebaseAuth.currentUser();
    Map value;
    if(formState.validate()){
      FirebaseUser user = await firebaseAuth.currentUser();
      if(user == null){
        AuthResult result = await firebaseAuth.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text);
        user = result.user;

            Firestore.instance.collection("users")
            .document(user.uid)
            .setData({
                "id": user.uid,
                'username': _nameController.text,
                "email":_emailController.text,
        }).catchError((e)=>{print(e.toString())});

      }else{
        Fluttertoast.showToast(msg: "user not null");
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => new HomePage()));
    }

  }



}



