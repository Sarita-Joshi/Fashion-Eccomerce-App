import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

//my package imports
import 'package:flutterapp2/components/Products.dart';
import 'package:flutterapp2/pages/Cart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.redAccent,
          elevation: 0.5,
          title: Text('E-com fashion'),
          actions: <Widget>[
            new IconButton(icon: Icon(Icons.search, color:Colors.white), onPressed: null),
            new IconButton(icon: Icon(Icons.shopping_cart, color:Colors.white), onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> new Cart()));
            }),
          ],
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
//            heaDER Part
              new UserAccountsDrawerHeader(
                accountName: Text('Sarita Joshi'),
                accountEmail: Text('abc@example.com'),
                currentAccountPicture:  GestureDetector(
                  child: new CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                decoration: new BoxDecoration(
                  color: Colors.red,
                ),
              ),

//        body of drawer
              InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('Home'),
                  leading: Icon(Icons.home, color: Colors.redAccent),
                ),
              ),

              InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('My Account'),
                  leading: Icon(Icons.person, color: Colors.redAccent),
                ),
              ),

              InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('My Orders'),
                  leading: Icon(Icons.shopping_basket, color: Colors.redAccent),
                ),
              ),

              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new Cart()));
                },
                child: ListTile(
                  title: Text('Shopping cart'),
                  leading: Icon(Icons.shopping_cart, color: Colors.redAccent,),
                ),
              ),

              InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('Favorites'),
                  leading: Icon(Icons.favorite, color: Colors.redAccent),
                ),
              ),

              Divider(),
              InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('Settings'),
                  leading: Icon(Icons.settings, color: Colors.green),
                ),
              ),

              InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('About'),
                  leading: Icon(Icons.help, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),

        body: Column(
            children: <Widget>[
             // Text("hi")
              Flexible(
              child: Products()
              )
            ],
        )

    );
  }
}

