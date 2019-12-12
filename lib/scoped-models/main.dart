import 'package:first_app/scoped-models/connected_products.dart';
import 'package:first_app/scoped-models/products.dart';
import 'package:first_app/scoped-models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with ConnectedProducts, UserModel, ProductsModel {
}