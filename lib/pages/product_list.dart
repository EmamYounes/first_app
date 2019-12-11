import 'package:first_app/pages/product_edit.dart';
import 'package:first_app/scoped-models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              onDismissed: (DismissDirection dismissDirection) {
                if (dismissDirection == DismissDirection.endToStart) {
                  model.selectProduct(index);
                  model.deleteProduct();
                } else if (dismissDirection == DismissDirection.startToEnd) {
                } else {}
              },
              background: Container(
                color: Colors.red,
              ),
              key: Key(model.products[index].title),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(model.products[index].image),
                    ),
                    title: Text(model.products[index].title),
                    subtitle:
                        Text('\$${model.products[index].price.toString()}'),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider()
                ],
              ),
            );
          },
          itemCount: model.products.length);
    });
  }

  Widget _buildEditButton(
      BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(
        Icons.edit,
      ),
      onPressed: () {
        model.selectProduct(index);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ProductEditPage();
        }));
      },
    );
  }
}
