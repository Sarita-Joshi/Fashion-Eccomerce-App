import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
            Category(
              image_caption: 'shirt',
              image_location: 'images/cats/tshirt.png',
            ),
          Category(
            image_caption: 'Dresses',
            image_location: 'images/cats/dress.png',
          ),
          Category(
            image_caption: 'Formals',
            image_location: 'images/cats/formal.png',
          ),
          Category(
            image_caption: 'Casuals',
            image_location: 'images/cats/informal.png',
          ),
          Category(
            image_caption: 'Shoes',
            image_location: 'images/cats/shoe.png',
          ),
          Category(
            image_caption: 'Jeans',
            image_location: 'images/cats/jeans.png',
          ),
          Category(
            image_caption: 'Others',
            image_location: 'images/cats/accessories.png',
          ),

        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  String image_location;
  String image_caption;

  Category({
    this.image_location,
    this.image_caption
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell( onTap: (){},
        child: Container(
          width: 72,
        child: ListTile(
          title: Image.asset(image_location, width: 80, height: 40,),
          subtitle: Container(
              child: Text(image_caption, style: TextStyle(fontSize: 11),) ,
              alignment: Alignment.topCenter,
          ),
        ),
      ),
      ),
    );
  }
}

