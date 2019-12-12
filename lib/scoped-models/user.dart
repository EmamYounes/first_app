import 'package:first_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

import 'connected_products.dart';

class UserModel extends ConnectedProducts {
  void login(String email, String password) {
    authenticatedUser = User(id: "1", email: email, password: password);
  }
}
