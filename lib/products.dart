import 'package:flutter/material.dart';

class Prodects extends StatelessWidget {
  final List<Map<String, dynamic>> product;

  Prodects(this.product);

  Widget buildProducetItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product[index]['image']),
          Container(
            child: Text(product[index]['title']),
            margin: EdgeInsets.only(top: 10.0),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () => Navigator.pushNamed<bool>(
                    context, '/product/' + index.toString()),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildProductList() {
    Widget productCards;
    if (product.isNotEmpty) {
      productCards = ListView.builder(
        itemBuilder: buildProducetItem,
        itemCount: product.length,
      );
    } else {
      // if you don't need to return any widget return empty container
      //productCards=Container();

      productCards = Center(
        child: Text('There is no products to display , please add some'),
      );
    }
    return productCards;
  }

  Widget build(context) {
    return buildProductList();
  }
}
