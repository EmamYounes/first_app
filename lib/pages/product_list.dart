import 'package:first_app/pages/product_edit.dart';
import 'package:first_app/scoped-models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatefulWidget {
  final MainModel model;

  ProductListPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProductListPageState();
  }
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    widget.model.fetchProduct(onlyForUser:true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              onDismissed: (DismissDirection dismissDirection) {
                if (dismissDirection == DismissDirection.endToStart) {
                  model.selectProduct(model.allProducts[index].id);
                  model.deleteProduct();
                } else if (dismissDirection == DismissDirection.startToEnd) {
                } else {}
              },
              background: Container(
                color: Colors.red,
              ),
              key: Key(model.allProducts[index].title),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(model.allProducts[index].image),
                    ),
                    title: Text(model.allProducts[index].title),
                    subtitle:
                        Text('\$${model.allProducts[index].price.toString()}'),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider()
                ],
              ),
            );
          },
          itemCount: model.allProducts.length);
    });
  }

  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(
        Icons.edit,
      ),
      onPressed: () {
        model.selectProduct(model.allProducts[index].id);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ProductEditPage();
        }));
      },
    );
  }
}
