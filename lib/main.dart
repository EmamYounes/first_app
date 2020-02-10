import 'package:first_app/models/product.dart';
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
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _model.autoAuthenticate();
    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  Widget build(context) {
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
          '/': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : ProductsPage(_model),
          '/admin': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : ProductAdminPage(_model),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (!_isAuthenticated) {
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => AuthPage(),
            );
          }
          final List<String> pathElements = settings.name.split('/');
          String productId = pathElements[2];
          final Product product =
              _model.allProducts.firstWhere((Product product) {
            return product.id == productId;
          });
          _model.selectProduct(productId);
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'product') {
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  !_isAuthenticated ? AuthPage() : ProductPage(product),
            );
          }
          return null;
        },
        // if routes fail or return null the onUnknownRoute will work in this case
        // Default route (screen)
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) =>
                  !_isAuthenticated ? AuthPage() : ProductsPage(_model));
        },
      ),
      model: _model,
    );
  }
}
