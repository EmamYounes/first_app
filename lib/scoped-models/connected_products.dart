import 'package:first_app/models/product.dart';
import 'package:first_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class ConnectedProducts extends Model {
  List<Product> products = [];
  User authenticatedUser;
  int selProductIndex;

  void addProduct(
      String title, String description, String image, double price) {
    Product newProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: authenticatedUser.email,
        userID: authenticatedUser.id);
    products.add(newProduct);
    selProductIndex = null;
    notifyListeners();
  }
}
