import 'package:first_app/models/product.dart';
import 'package:first_app/scoped-models/main.dart';
import 'package:first_app/widget/products/address_tag.dart';
import 'package:first_app/widget/products/price_tag.dart';
import 'package:first_app/widget/ui_elements/title_default.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(product.image),
            height: 300.0,
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/food.jpg'),
          ),
          _buildTitlePriceContainer(),
          AddressTag('Union Square, San Francisco'),
          Text(product.userEmail),
          _buildActionButtons(context)
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.info),
            onPressed: () => Navigator.pushNamed<bool>(
                context, '/product/' + model.allProducts[productIndex].id),
          ),
          IconButton(
              icon: Icon(model.allProducts[productIndex].isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Colors.red,
              onPressed: () {
                model.selectProduct(model.allProducts[productIndex].id);
                model.toggleProductFavoriteStatus();
              }),
        ],
      );
    });
  }

  Container _buildTitlePriceContainer() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleDefault(product.title),
          SizedBox(
            width: 8.0,
          ),
          Pricetag(product.price.toString())
        ],
      ),
      margin: EdgeInsets.only(top: 10.0),
    );
  }
}
