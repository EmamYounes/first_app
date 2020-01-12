import 'package:first_app/scoped-models/main.dart';
import 'package:first_app/widget/products/products.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;

  ProductsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    widget.model.fetchProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('EasyList'),
          actions: <Widget>[
            ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
                return IconButton(
                  icon: Icon(model.displayFavoritesOnly
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () {
                    model.toggleDisplayMode();
                  },
                );
              },
            )
          ],
        ),
        body: _buildProductList());
  }

  Widget _buildProductList() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center(
          child: Text('No Product Found'),
        );
        if (model.displayProducts.length > 0 && !model.isLoading) {
          content = Products();
        } else if (model.isLoading) {
          content = Center(
            child: CircularProgressIndicator(),
          );
        }
        return content;
      },
    );
  }

  Drawer _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          )
        ],
      ),
    );
  }
}
