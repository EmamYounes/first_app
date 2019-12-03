import 'package:first_app/pages/auth.dart';
import 'package:first_app/pages/products.dart';
import 'package:flutter/material.dart';

import './pages/product.dart';
import './pages/productsAdmin.dart';

//import './pages/auth.dart';
// import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());

//  to add debuging paint on the UI screen

//  debugPaintPointersEnabled=true;
//  debugPaintSizeEnabled=true;
//  debugPaintBaselinesEnabled=true;
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> newProduct) {
    setState(() {
      _products.add(newProduct);
    });
  }

  void _updateProduct(int index, Map<String, dynamic> product) {
    setState(() {
      _products[index] = product;
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(
          accentColor: Colors.deepPurple,
          primarySwatch: Colors.deepOrange,
          buttonColor: Colors.deepPurple,
          brightness: Brightness.light),
//      home: AuthPage(),
      routes: {
        // that's mean home page => '/'
        '/': (BuildContext context) => AuthPage(),
        '/products': (BuildContext context) => ProductsPage(_products),
        '/admin': (BuildContext context) => ProductAdminPage(
            _addProduct, _updateProduct, _deleteProduct, _products),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        int index = int.parse(pathElements[2]);
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(
                _products[index]['title'],
                _products[index]['image'],
                _products[index]['price'],
                _products[index]['description']),
          );
        }
        return null;
      },
      // if routes fail or return null the onUnknownRoute will work in this case
      // Default route (screen)
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => ProductsPage(_products));
      },
    );
  }
}
