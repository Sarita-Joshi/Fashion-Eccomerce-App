



//google design guidelines to imporve ui
import 'package:flutter/material.dart';

//my package imports
import 'package:flutterapp2/pages/home.dart';
import 'package:flutterapp2/pages/login.dart';


void main(){
  runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red.shade900
      ),
      home: Login(),
    ),
  );
}

/*
//column = lin layout vertical
//row =    -"-   -"-  horizontal
//listview = listview
//gridview.count() = gridlayout

//stateless and stateful widgets

 */


/*


//column = lin layout vertical
//row =    -"-   -"-  horizontal
//listview = listview
//gridview.count() = gridlayout

//stateless and stateful widgets


look into sliver app bar, flexible spacebar and background, bg greeting, (paralax effect)
sliver persistent header
tab bar, tabs



 */