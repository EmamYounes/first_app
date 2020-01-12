import 'package:first_app/pages/auth.dart';
import 'package:first_app/pages/products.dart';
import 'package:first_app/scoped-models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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
  Widget build(context) {
    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
      child: MaterialApp(
        theme: ThemeData(
            accentColor: Colors.deepPurple,
            primarySwatch: Colors.deepOrange,
            buttonColor: Colors.deepPurple,
            brightness: Brightness.light),
//      home: AuthPage(),
        routes: {
          // that's mean home page => '/'
          '/': (BuildContext context) => AuthPage(),
          '/products': (BuildContext context) => ProductsPage(model),
          '/admin': (BuildContext context) => ProductAdminPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          int index = int.parse(pathElements[2]);
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'product') {
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(index),
            );
          }
          return null;
        },
        // if routes fail or return null the onUnknownRoute will work in this case
        // Default route (screen)
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage(model));
        },
      ),
      model: model,
    );
  }
}
