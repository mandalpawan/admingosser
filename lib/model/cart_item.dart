import 'package:cloud_firestore/cloud_firestore.dart';
class CartItemModel {
  static const ID="id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const QUANTITY="quantity";
  static const PRODUCT_ID="productId";

  String _id;
  String _name;
  String _image;
  int _price;
  int _quantity;
  String _product_id;

  //  getters
String get id => _id;

  String get name => _name;

  String get image => _image;

  int get price => _price;

  int get quantity => _quantity;

  String get product_id => _product_id;


  CartItemModel.fromMap(Map data){
    _id =data[ID];
    _name =  data[NAME];
    _image =  data[IMAGE];
    _price = data[PRICE];
    _quantity = data[QUANTITY];
    _product_id =data[PRODUCT_ID];

  }

  Map toMap() => {
    ID:_id,
    IMAGE: _image,
    NAME: _name,
    QUANTITY: _quantity,
    PRICE: _price,
    PRODUCT_ID:_product_id
  };

  }



