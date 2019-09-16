import 'package:first_app/products_control.dart';
import 'package:flutter/material.dart';
import './products.dart';

class ProductManager extends StatefulWidget {
  final Map<String, String> startProduct;
  ProductManager({this.startProduct}) {
    // do nothing
  }
  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<Map<String, String>> _products = [];
  @override
  void initState() {
    if (widget.startProduct != null) {
      _products.add(widget.startProduct);
    }
    super.initState();
  }

  void addProduct(Map<String, String> newProduct) {
    setState(() {
      _products.add(newProduct);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.all(10.0), child: ProductControl(addProduct)),
        Expanded(child: Prodects(_products, deleteProduct: _deleteProduct))
      ],
    );
  }
}
