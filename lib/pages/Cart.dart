import 'package:flutter/material.dart';

//my imports
import 'package:flutterapp2/components/cart_products.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0.5,
        title: Text('Cart'),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search, color:Colors.white), onPressed: null),
         ],
      ),

      body: new Cart_products(),

      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text("Total:"),
                subtitle: Text("₹2300"),
              ),
            ),
            Expanded(
              child: MaterialButton(onPressed: (){},
              child: Text("Check out", style: TextStyle(color: Colors.white),),
                color: Colors.red,
              ),
            )

          ],
        ),
      ),

    );
  }
}
