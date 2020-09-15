import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const NAME = "Name";
  static const PICTURE = "image";
  static const PRICE = "price";
  static const QUANTITY = "qty";
  static const CATEGORY = "category";
  static const ID = "id";

  //private vaiable
  String _name;
  String _picture;
  int _quantity;
  int _price;
  int _totalprice;
  String _category;
  String _id;

  //getters to accces
  String get name => _name;
  String get picture => _picture;
  int get quantity => _quantity;
  int get price => _price;
  int get totalpriced => _totalprice;
  String get category => _category;
  String get id => _id;

//constructor
  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];
    _picture = snapshot.data[PICTURE];
    _price = int.parse(snapshot.data[PRICE]);
    _quantity=snapshot.data[QUANTITY];
    _category=snapshot.data[CATEGORY];
    _totalprice=(int.parse(snapshot.data[PRICE]))*snapshot.data[QUANTITY];
  }
}
