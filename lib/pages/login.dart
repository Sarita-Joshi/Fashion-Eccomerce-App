import 'package:flutter/material.dart';
import 'package:flutterapp2/pages/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutterapp2/pages/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  SharedPreferences preferences; //store some values of the app
  bool loading = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    //won't wait for anyone
    setState(() {
      loading = true;
    });
    FirebaseUser user = await firebaseAuth.currentUser().then((value){
      if(value!=null){
        setState(() {
          isLoggedIn = true;
        });
      }
    });
    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => new HomePage()));
    }
    //await is => hold on until we get the data
    preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = false;
    });
  }

  Future handleEmailSignIn() async{
    preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });


      Fluttertoast.showToast(msg: "Login was successful");
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => new HomePage()));

  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await firebaseAuth.signInWithCredential(
        credential);
    final FirebaseUser firebaseUser = authResult.user;
    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance.collection("users")
          .where("id", isEqualTo: firebaseUser.uid).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
//        insert new user
        Firestore.instance.collection("users")
            .document(firebaseUser.uid)
            .setData({
          "id": firebaseUser.uid,
          'username': firebaseUser.displayName,
          "profile_picture": firebaseUser.photoUrl,
        });

        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("email", firebaseUser.email);
        await preferences.setString("username", firebaseUser.displayName);
        await preferences.setString("photoUrl", firebaseUser.photoUrl);
      } else {
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[0]['username']);
        await preferences.setString("email", documents[0]['email']);
        await preferences.setString(
            "photoUrl", documents[0]['profile_picture']);
      }
      Fluttertoast.showToast(msg: "Login was successful");
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => new HomePage()));
    } else {
      Fluttertoast.showToast(msg: "Login failed!");
    }
  }

  @override
  Widget build(BuildContext context) {

    Widget _signInButton() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          splashColor: Colors.blueGrey,
          onPressed: () {handleSignIn();},
          color: Colors.white.withOpacity(0.9),
          minWidth: MediaQuery.of(context).size.width,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          highlightElevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage("images/google_sign_in.png"), height: 28.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

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
//            alignment: Alignment.topCenter,
//            child: Image.asset('images/lg.png'),
//            width: 150,
//            height: 150,
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.4),
          ),
          Padding(
            padding: const EdgeInsets.only(top:250),
            child: Center(
                child: Form(
                  key: formkey,
                  child: Column(children: <Widget>[
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

//                  BUTTON
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red.withOpacity(0.9),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12,0,0,0),
                          child: MaterialButton(
                            onPressed: (){},
                            minWidth: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.email, color: Colors.white.withOpacity(0.9),size: 30,),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('Login with Email Id',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white,
                                      fontSize: 18),),
                                ),

                              ],
                            ),

                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('or',
                      style: TextStyle(color: Colors.white,
                      fontSize: 20,),
                      ),
                    ),
                    _signInButton(),
                  ],),
                ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
              child: Column(
                children: <Widget>[
                  Text('Forgot Password?',
                      style: TextStyle(color: Colors.white,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[

                      Text("Don't have an account?",
                          style: TextStyle(color: Colors.white,
                          )),
                      InkWell(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> new SignUp()));
                        },
                        child: Text(' Sign up',
                            style: TextStyle(color: Colors.red,
                              fontSize: 16,)),
                      ),
                    ],
            ),
                ],
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
  }}
