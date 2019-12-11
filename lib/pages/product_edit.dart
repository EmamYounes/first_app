import 'package:first_app/models/product.dart';
import 'package:first_app/scoped-models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductEditPage();
  }
}

class _ProductEditPage extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget pageContent =
            _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == null
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                ),
                body: pageContent,
              );
      },
    );
  }

  GestureDetector _buildPageContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTextField(product),
              SizedBox(
                height: 10.0,
              ),
              _buildSumitButton()
              /*        GestureDetector(
          onTap: _submitForm,
          child: Container(
            child: Text(
              'Save',
              textAlign: TextAlign.center,
            ),
            color: Colors.blueAccent,
          ),
        )*/
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSumitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
          textColor: Colors.white,
          child: Text('Save'),
          onPressed: () => _submitForm(model.addProduct, model.updateProduct,
              model.selectedProductIndex),
        );
      },
    );
  }

  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Title'),
      initialValue: product == null ? '' : product.title,
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Title is Required and should be 5+ characters long.';
        }
      },
      onSaved: (String title) {
        _formData['title'] = title;
      },
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Description'),
      maxLines: 4,
      initialValue: product == null ? '' : product.description,
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return 'Description is Required and should be 10+ characters long.';
        }
      },
      onSaved: (String description) {
        _formData['description'] = description;
      },
    );
  }

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Price'),
      keyboardType: TextInputType.number,
      initialValue: product == null ? '' : product.price.toString(),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is Required and should be number.';
        }
      },
      onSaved: (String price) {
        _formData['price'] = double.parse(price);
      },
    );
  }

  void _submitForm(Function addProduct, Function updateProduct,
      [int selectedProductIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (selectedProductIndex == null) {
      addProduct(Product(
          title: _formData['title'],
          image: _formData['image'],
          price: _formData['price'],
          description: _formData['description']));
    } else {
      updateProduct(
          Product(
              title: _formData['title'],
              image: _formData['image'],
              price: _formData['price'],
              description: _formData['description']));
    }
    Navigator.pushReplacementNamed(context, '/products');
  }
}
