import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutterapp2/pages/home.dart';

class ProductDetails extends StatefulWidget {
  var product_detail_name;
  var product_detail_price;
  var product_detail_old_price;
  var product_detail_picture;

  ProductDetails({
    this.product_detail_name,
    this.product_detail_price,
    this.product_detail_old_price,
    this.product_detail_picture,
});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0.5,
        title: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> new HomePage()));
          },
         child: Text('E-com fashion'),
        ),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search, color:Colors.white), onPressed: null),
          new IconButton(icon: Icon(Icons.shopping_cart, color:Colors.white), onPressed: null),
        ],

      ),

//      body
    body: new ListView(
      children: <Widget>[
        new Container(
          height: 260,
          child: GridTile(
            child: Container(
              color: Colors.white, 
              child: Image.asset(widget.product_detail_picture),
            ),
            footer: new Container(
              color: Colors.white70,
              height: 40,
              child: ListTile(
                leading: new Text(widget.product_detail_name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                title: new Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("₹${widget.product_detail_old_price}",
                      style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),),
                    ),
                    Text("₹${widget.product_detail_price}",
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),

                  ],
                ),
              ),
            ),
          ),
        ),

//        first buttons
        Row(
          children: <Widget>[
//            the size button
            Expanded(
              child:MaterialButton(
                onPressed:(){
                  showDialog(context: context,
                  builder: (context){
                    return new AlertDialog(
                      title: Text('Select Size'),
                      content: Text('Choose the size'),
                      actions: <Widget>[
                        MaterialButton(
                          onPressed: (){
                            Navigator.of(context).pop(context);
                          },
                          child: Text('close'))
                      ],
                    );
                  });
                },
              color: Colors.white,
              textColor: Colors.grey,
                elevation: 0.2,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text("Size")
                  ),
                  Expanded(
                      child: Icon(Icons.arrow_drop_down)
                  ),
                ],
              ),)
            ),
            //            the size button
            Expanded(
                child:MaterialButton(
                  onPressed:(){
                    showDialog(context: context,
                        builder: (context){
                          return new AlertDialog(
                            title: Text('Select color'),
                            content: Text('Choose a color'),
                            actions: <Widget>[
                              MaterialButton(
                                  onPressed: (){
                                    Navigator.of(context).pop(context);
                                  },
                                  child: Text('close'))
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text("Color")
                      ),
                      Expanded(
                          child: Icon(Icons.arrow_drop_down)
                      ),
                    ],
                  ),)
            ),
            Expanded(
                child:MaterialButton(
                  onPressed:(){
                    showDialog(context: context,
                        builder: (context){
                          return new AlertDialog(
                            title: Text('Select Qty'),
                            content: Text('Choose a quantity'),
                            actions: <Widget>[
                              MaterialButton(
                                  onPressed: (){
                                    Navigator.of(context).pop(context);
                                  },
                                  child: Text('close'))
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text("Qty")
                      ),
                      Expanded(
                          child: Icon(Icons.arrow_drop_down)
                      ),
                    ],
                  ),)
            )
          ],
        ),
        //        second buttons
        Row(
          children: <Widget>[
//            the size button
            Expanded(
                child:MaterialButton(onPressed:(){},
                  color: Colors.red,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: Text("Buy now"),
                ),
            ),
            new IconButton(icon: Icon(Icons.add_shopping_cart, color: Colors.red,)),
            new IconButton(icon: Icon(Icons.favorite_border, color: Colors.red,)),
          ],
        ),
        Divider(),
        ListTile(
          title: Text("Product Details"),
          subtitle: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset."),
        ),
        Divider(),
        Row(
          children: <Widget>[
            Padding(padding: const EdgeInsets.fromLTRB(12,5,5,5),
            child: Text("Product Name", style: TextStyle(color: Colors.grey),),),
            Padding(padding: const EdgeInsets.fromLTRB(12,5,5,5),
              child: Text(widget.product_detail_name, style: TextStyle(color: Colors.black),),),
          ],),
        Row(
          children: <Widget>[
            Padding(padding: const EdgeInsets.fromLTRB(12,5,5,5),
              child: Text("Product Brand", style: TextStyle(color: Colors.grey),),),
//          to create brand
            Padding(padding: const EdgeInsets.fromLTRB(12,5,5,5),
              child: Text("Brand X", style: TextStyle(color: Colors.black),),),
//
          ],),
        Row(
          children: <Widget>[
            Padding(padding: const EdgeInsets.fromLTRB(12,5,5,5),
              child: Text("Product Condition", style: TextStyle(color: Colors.grey),),),
//          add product condition
          Padding(padding: const EdgeInsets.fromLTRB(12,5,5,5),
              child: Text("NEW", style: TextStyle(color: Colors.black),),),
          ],),

      Divider(),
      Padding(
        padding: const EdgeInsets.all(8),
          child: Text('Smilar Products',
          style: TextStyle(fontSize: 17),)),
//        similar products section
      Container(
        height: 360,
        child: Similar_products(),
      )

      ],
    )


    );
  }
}

class Similar_single_prod extends StatelessWidget {
  var prod_name;
  var prod_picture;
  var prod_old_price;
  var prod_price;

  Similar_single_prod({
    this.prod_name,
    this.prod_picture,
    this.prod_old_price,
    this.prod_price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: prod_name,
        child: Material(
          child: InkWell(
            onTap: () =>
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) =>
                    //passing values of selected product
                    new ProductDetails(
                      product_detail_name: prod_name,
                      product_detail_old_price: prod_old_price,
                      product_detail_picture: prod_picture,
                      product_detail_price: prod_price,
                    ))),
            child: GridTile(
              footer: Container(
                height: 25,
                color: Colors.white,
                child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          prod_name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),),

                      Padding(padding: const EdgeInsets.fromLTRB(12,5,5,5),
                        child: Text(
                          "₹$prod_price",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight:
                              FontWeight.bold
                          ),),),
                      Padding(padding: const EdgeInsets.fromLTRB(10,5,5,5),
                        child: Text(
                          "₹$prod_old_price",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough
                          ),),),
                    ]
                ),

              ),
              child: Image.asset(prod_picture),
            ),
          ),)
        ,
      )
      ,
    );
  }
}

class Similar_products extends StatefulWidget {
  @override
  _Similar_productsState createState() => _Similar_productsState();
}

class _Similar_productsState extends State<Similar_products> {

  var prod_list = [
    {
      "name": "Blazer",
      "picture": "images/products/blazer1.jpeg",
      "old_price": 1200,
      "price": 850,
    },
    {
      "name": "Red dress",
      "picture": "images/products/dress1.jpeg",
      "old_price": 800,
      "price": 550,
    },
    {
      "name": "heals",
      "picture": "images/products/hills1.jpeg",
      "old_price": 1000,
      "price": 920,
    },
    {
      "name": "Shoes",
      "picture": "images/products/shoe1.jpg",
      "old_price": 700,
      "price": 450,
    },

  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: prod_list.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2
      ),
      itemBuilder: (BuildContext context, int index) {
        return Similar_single_prod(
          prod_name: prod_list[index]['name'],
          prod_picture: prod_list[index]['picture'],
          prod_old_price: prod_list[index]['old_price'],
          prod_price: prod_list[index]['price'],
        );
      },
    );
  }
}
