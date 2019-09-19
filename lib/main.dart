import 'package:first_app/pages/ProductsPage.dart';
import 'package:flutter/material.dart';

import './pages/ProductPage.dart';
import './pages/productsAdminPage.dart';
//import './pages/authPage.dart';
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
  final List<Map<String, dynamic>> product = [];

  void _addProduct(Map<String, dynamic> newProduct) {
    setState(() {
      product.add(newProduct);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      product.removeAt(index);
    });
  }

  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.deepOrange, brightness: Brightness.light),
//      home: AuthPage(),
      routes: {
        // that's mean home page => '/'
        '/': (BuildContext context) => ProductsPage(product),
        '/admin': (BuildContext context) =>
            ProductAdminPage(_addProduct, _deleteProduct),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        int index = int.parse(pathElements[2]);
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) =>
                ProductPage(product[index]['title'], product[index]['image']),
          );
        }
        return null;
      },
      // if routes fail or return null the onUnknownRoute will work in this case
      // Default route (screen)
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => ProductsPage(product));
      },
    );
  }
}
