import 'dart:convert';

import 'package:first_app/models/product.dart';
import 'package:first_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

class ConnectedProductsModel extends Model {
  List<Product> _products = [];
  User _authenticatedUser;
  String _selProductId;
  String productUrl =
      'https://flutter-products-46db9.firebaseio.com/products.json';
  bool _isLoading = false;

  Future<Null> addProduct(
      String title, String description, String image, double price) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://vaya.in/recipes/wp-content/uploads/2018/02/Milk-Chocolate-1.jpg',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userID': _authenticatedUser.id
    };
    return http
        .post(productUrl, body: json.encode(productData))
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print('addProduct${response}');
      Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: _authenticatedUser.email,
          userID: _authenticatedUser.id);
      _products.add(newProduct);
      _isLoading = false;
      notifyListeners();
    });
  }
}

class ProductsModel extends ConnectedProductsModel {
  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayProducts {
    if (_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  String get selectedProductId {
    return _selProductId;
  }

  Product get selectedProduct {
    if (selectedProductId == null) return null;
    return _products.firstWhere((Product product) {
      return product.id == selectedProductId;
    });
  }

  int get selectedProductIndex {
    return _products.indexWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  Future<Null> updateProduct(
      String title, String description, String image, double price) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image': 'https://cdn.getyourguide.com/img/tour_img-1728184-146.jpg',
      'price': price,
      'userEmail': selectedProduct.userEmail,
      'userID': selectedProduct.userID
    };
    return http
        .put(
            'https://flutter-products-46db9.firebaseio.com/products/${selectedProduct.id}.json',
            body: json.encode(updateData))
        .then((http.Response response) {
      print('updateProduct${response}');
      _isLoading = false;
      Product updatedProduct = Product(
          id: selectedProduct.id,
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: selectedProduct.userEmail,
          userID: selectedProduct.userID);
      _products[selectedProductIndex] = updatedProduct;
      notifyListeners();
    });
  }

  void deleteProduct() {
    _isLoading = true;
    final _deletedProductId = selectedProduct.id;
    _products.removeAt(selectedProductIndex);
    _selProductId = null;
    notifyListeners();
    http
        .delete(
            'https://flutter-products-46db9.firebaseio.com/products/${_deletedProductId}.json')
        .then((http.Response response) {
      print('deleteProduct${response}');
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<Null> fetchProduct() {
    _isLoading = true;
    notifyListeners();
    return http.get(productUrl).then((http.Response response) {
      final List<Product> fetchedProductList = [];
      print(response.body);
      final Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            image: productData['image'],
            price: productData['price'],
            userEmail: productData['userEmail'],
            userID: productData['userID']);
        fetchedProductList.add(product);
      });
      _products = fetchedProductList;
      _isLoading = false;
      notifyListeners();
    });
  }

  void selectProduct(String productId) {
    _selProductId = productId;
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatues = !isCurrentlyFavorite;
    final Product updatedProduct = Product(
        id: selectedProduct.id,
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        userEmail: selectedProduct.userEmail,
        userID: selectedProduct.userID,
        isFavorite: newFavoriteStatues);
    _products[selectedProductIndex] = updatedProduct;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

class UserModel extends ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User(id: "1", email: email, password: password);
  }
}

class UtilityModel extends ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
