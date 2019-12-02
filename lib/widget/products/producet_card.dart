import 'package:first_app/widget/products/address_tag.dart';
import 'package:first_app/widget/products/price_tag.dart';
import 'package:first_app/widget/ui_elements/title_default.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product['image']),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleDefault(product['title']),
                SizedBox(
                  width: 8.0,
                ),
                Pricetag(product['price'].toString())
              ],
            ),
            margin: EdgeInsets.only(top: 10.0),
          ),
          AddressTag('Union Square, San Francisco'),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                color: Theme.of(context).accentColor,
                icon: Icon(Icons.info),
                onPressed: () => Navigator.pushNamed<bool>(
                    context, '/product/' + productIndex.toString()),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colors.red,
                onPressed: () => Navigator.pushNamed<bool>(
                    context, '/product/' + productIndex.toString()),
              )
            ],
          )
        ],
      ),
    );
  }
}
