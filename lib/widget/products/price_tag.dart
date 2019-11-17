import 'package:flutter/material.dart';

class Pricetag extends StatelessWidget {
  String price;

  Pricetag(this.price);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 6.0),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        price,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
