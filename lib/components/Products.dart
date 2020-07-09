import 'package:flutter/material.dart';
import 'package:spannable_grid/spannable_grid.dart';
import 'package:carousel_pro/carousel_pro.dart';

import 'package:flutterapp2/pages/productDetails.dart';
import 'package:flutterapp2/components/horizontal_listview.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}


class _ProductsState extends State<Products> {

  var prod_list = [
    {
      "name": "Blazer1",
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
      "name": "heels",
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
    {
      "name": "Blazer woman",
      "picture": "images/products/blazer2.jpeg",
      "old_price": 1200,
      "price": 850,
    },
    {
      "name": "Black dress",
      "picture": "images/products/dress2.jpeg",
      "old_price": 800,
      "price": 550,
    },
    {
      "name": "Red heels",
      "picture": "images/products/hills2.jpeg",
      "old_price": 1000,
      "price": 920,
    },
    {
      "name": "Skirt",
      "picture": "images/products/skt1.jpeg",
      "old_price": 700,
      "price": 450,
    },

  ];



  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 200,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/c1.jpg'),
          AssetImage('images/m1.jpeg'),
          AssetImage('images/p4.jpg'),
          AssetImage('images/w3.jpeg'),
          AssetImage('images/w4.jpeg'),
        ],
        autoplay: false,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        dotBgColor: Colors.transparent,
      ),
    );

    List<SpannableGridCellData> cells = List();

    cells.add(SpannableGridCellData(
      column: 1,
      row: 1,
      columnSpan: 2,
      rowSpan: 1,

      id: "image cousal",
      child: Container(
        color: Colors.lime,
        child: image_carousel,
      ),
    ));

    cells.add(SpannableGridCellData(
      column: 1,
      row: 2,
      columnSpan: 2,
      rowSpan: 1,
      id: "horizontal list",
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            new Padding(padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text('Categories'),
                alignment: Alignment.centerLeft,),),
            //horizontal listview
            HorizontalList(),

            new Padding(padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text('Browse Products'),
                alignment: Alignment.centerLeft,),),

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
                                title: Text('Sort'),
                                content: Text('Choose options'),
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
                              child: Text("Sort by: ")
                          ),
                          Expanded(
                              child: Text("recent")
                          ),
                          Icon(Icons.arrow_drop_down)
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
                                title: Text('Filter'),
                                content: Text('Apply filter'),
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
                              child: Text("Filter: ")
                          ),
                          Expanded(
                              child: Text("none")
                          ),
                               Icon(Icons.arrow_drop_down)

                        ],
                      ),)
                ),

              ],
            ),
          ],
        ),
      ),
    ));



    cells.add(SpannableGridCellData(
      column: 1,
      row: 3,
      columnSpan: 2,
      rowSpan: 3,
      id: "product list",
      child: GridView.builder(
        itemCount: prod_list.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Single_prod(
              prod_name: prod_list[index]['name'],
              prod_picture: prod_list[index]['picture'],
              prod_old_price: prod_list[index]['old_price'],
              prod_price: prod_list[index]['price'],
            ),
          );
        },
      ),
    ));


    return ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
     // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //Text("hi"),
      SpannableGrid(
      columns: 2,
      rows: 5,
      cells: cells,
      onCellChanged: (cell) { print('Cell ${cell.id} changed'); },
    ),
      ]
    );
  }
}

class Single_prod extends StatelessWidget {
  var prod_name;
  var prod_picture;
  var prod_old_price;
  var prod_price;

  Single_prod({
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
