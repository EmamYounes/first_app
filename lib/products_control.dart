import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function addProdyct;
  ProductControl(this.addProdyct);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      child: Text('Add Product'),
      onPressed: () {
        addProdyct({'title':'Chocolate','image':'assets/food.jpg'});
      },
    );
  }
}
