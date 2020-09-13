import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel{
  static const ID = "id";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const DESCRIPTION = "description";
  static const CREATED_AT = "createdAt";
  static const NAME = "name";
  static const PHONE ="phone";
  static const HOME = "home";
  static const PIN = "pin";
  static const ROAD = "road";
  static const LAND = "land";
  static const CITY = "city";



  String _id;
  String _userId;
  String _status;
  String _description;
  String _name;
  String _phone;
  String _home;
  String _pin;
  String _road;
  String _land;
  String _city;
  int _createdAt;
  int _total;


//  getters
  String get id => _id;
  String get userId => _userId;
  String get description => _description;
  String get name => _name;
  String get phone => _phone;
  String get home => _home;
  String get pin => _pin;
  String get road => _road;
  String get land => _land;
  String get city => _city;
  String get status => _status;
  int get total => _total;
  int get createdAt => _createdAt;

  // public variable
  List cart;


  OrderModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data[ID];
    _total = snapshot.data[TOTAL];
    _status = snapshot.data[STATUS];
    _userId = snapshot.data[USER_ID];
    _createdAt = snapshot.data[CREATED_AT];
    cart = snapshot.data[CART];
    _description = snapshot.data[DESCRIPTION];
    _name = snapshot.data[NAME];
    _home = snapshot.data[HOME];
    _pin = snapshot.data[PIN];
    _road = snapshot.data[ROAD];
    _land = snapshot.data[LAND];
    _city = snapshot.data[CITY];
    _phone = snapshot.data[PHONE];
  }









}