import 'package:first_app/scoped-models/products.dart';
import 'package:first_app/widget/products/products.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('EasyList'),
          actions: <Widget>[
            ScopedModelDescendant<ProductsModel>(
              builder:
                  (BuildContext context, Widget child, ProductsModel model) {
                return IconButton(
                  icon: Icon(model.displayFavoritesOnly ? Icons.favorite : Icons
                      .favorite_border),
                  onPressed: () {
                    model.toggleDisplayMode();
                  },
                );
              },
            )
          ],
        ),
        body: Products());
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
