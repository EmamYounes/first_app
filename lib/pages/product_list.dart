import 'package:first_app/pages/product_edit.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function updateProduct;
  final Function deleteProduct;

  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            onDismissed: (DismissDirection dismissDirection) {
              if (dismissDirection == DismissDirection.endToStart) {
                deleteProduct(index);
              } else if (dismissDirection == DismissDirection.startToEnd) {
              } else {}
            },
            background: Container(
              color: Colors.red,
            ),
            key: Key(products[index]['title']),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(products[index]['image']),
                  ),
                  title: Text(products[index]['title']),
                  subtitle: Text('\$${products[index]['price'].toString()}'),
                  trailing: _buildEditButton(context, index),
                ),
                Divider()
              ],
            ),
          );
        },
        itemCount: products.length);
  }

  IconButton _buildEditButton(BuildContext context, int index) {
    return IconButton(
                  icon: Icon(
                    Icons.edit,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ProductEditPage(
                        product: products[index],
                        updateProduct: updateProduct,
                        productIndex: index,
                      );
                    }));
                  },
                );
  }
}
