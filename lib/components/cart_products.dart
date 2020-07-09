import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {

  var prod_cart_list = [
    {
      "name": "Red dress",
      "picture": "images/products/dress1.jpeg",
      "old_price": 800,
      "price": 550,
      "size":"M",
      "color":"Red",
      "qty":1,
    },
    {
      "name": "heels",
      "picture": "images/products/hills1.jpeg",
      "old_price": 1000,
      "price": 920,
      "size":"5",
      "color":"Black",
      "qty":1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index){
        return Single_cart_product(
          cart_prod_name: prod_cart_list[index]['name'],
          cart_prod_picture: prod_cart_list[index]['picture'],
          cart_prod_color: prod_cart_list[index]['color'],
          cart_prod_old_price: prod_cart_list[index]['old_price'],
          cart_prod_price: prod_cart_list[index]['price'],
          cart_prod_qty: prod_cart_list[index]['qty'],
          cart_prod_size: prod_cart_list[index]['size'],
        );
      },
    );
  }
}

class Single_cart_product extends StatelessWidget {
  var cart_prod_name;
  var cart_prod_picture;
  var cart_prod_old_price;
  var cart_prod_price;
  var cart_prod_size;
  var cart_prod_color;
  var cart_prod_qty;


  Single_cart_product({
    this.cart_prod_name,
    this.cart_prod_picture,
    this.cart_prod_old_price,
    this.cart_prod_price,
    this.cart_prod_size,
    this.cart_prod_color,
    this.cart_prod_qty,
  });
  @override
  Widget build(BuildContext context) {
    return Card(

      child: ListTile(
        leading: Image.asset(cart_prod_picture, width: 80, height: 100, fit: BoxFit.fitHeight,),
        title: Container(
          width: 200,
           child: Text(cart_prod_name)
        ),
        subtitle: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding( padding: const EdgeInsets.all(0), child: Text("Size: ")),
                Padding( padding: const EdgeInsets.all(4), child: Text(cart_prod_size)),

                Padding( padding: const EdgeInsets.fromLTRB(20,8,0,8), child: Text("Color: ")),
                Padding( padding: const EdgeInsets.all(4), child: Text(cart_prod_color)),
              ],
            ),
//            this is for product price
          Container(
            alignment: Alignment.topLeft,
            child: Text("$cart_prod_price",
            style: TextStyle(color: Colors.red,
            fontSize: 17,
            fontWeight: FontWeight.bold),),
          )
          ],
        ),
        trailing: FittedBox(
              fit: BoxFit.fill,
              child: Column(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_drop_up, size: 50,),
                      alignment: Alignment.topCenter, onPressed: (){}),
                  Padding(padding: const EdgeInsets.fromLTRB(10,5,0,0), child: Text("$cart_prod_qty", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),)),
                  IconButton(icon: Icon(Icons.arrow_drop_down, size: 50),
                      alignment: Alignment.topCenter, onPressed: (){}),
                  ],
              ),
        ),
      ),
    );
  }
}

