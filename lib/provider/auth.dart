import 'package:adminpage/model/order.dart';
import 'package:adminpage/model/user.dart';
import 'package:adminpage/services/order.dart';
import 'package:adminpage/services/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum Status { Unintialized, Unauthenticated, Authenticating, Authentiated }

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth;
  Firestore _firestore = Firestore.instance;


  FirebaseUser _user;
  Status _status = Status.Unintialized;

  //private variable
  UserServices _userServices = UserServices();
  UserModel _userModel;
  OrderServices _orderServices = OrderServices();
  int _totalSale = 0;
  int _totalprocessingItem = 0;
  int _totalSoldItem = 0;
  int _totalOrderedItem = 0;
  int _totalCancelItem = 0;

  //getters
  Status get status => _status;

  UserModel get userModel => _userModel;

  FirebaseUser get user => _user;

  int get totalSale => _totalSale;

  int get totalprocessingItem => _totalprocessingItem;

  int get totalSoldItem => _totalSoldItem;

  int get totalOrderedItem => _totalOrderedItem;

  int get totalCancelItem => _totalCancelItem;


  List<OrderModel> orders = [];
  List<UserModel> allUser = [];
  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  AuthProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  //signIn
  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      return true;
    } catch (e) {
      _status = Status.Unintialized;
      notifyListeners();
      print("error:" + e.toString());
      return false;
    }
  }

  //SignOut
  Future<void> signOut() {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  //singUp
  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((user) {
        Map<String, dynamic> values = {
          "name": name.text,
          "email": email.text,
          "id": user.user.uid,
        };
        _userServices.createUsers(values);
      });
      return true;
    } catch (e) {
      return onError(e.toString());
    }
  }

  //get all user

  getAllUser() async{
    allUser  = await _userServices.getUsers();
  }

  //get total ordered
  getOrders() async {
    orders = await _orderServices.getUserOrders();
    notifyListeners();
  }

  //get total sold price
  getTotalSale() async {
    for(OrderModel order in orders){
      _totalSale = _totalSale + order.total;
    }
        notifyListeners();
  }


  //get total ordered price
  getTotalOrdered() async {
    for(OrderModel order in orders){
      if(order.status == "0"){
        _totalOrderedItem = _totalOrderedItem + 1;
      }
    }
    notifyListeners();
  }

  //get total pending item
  getTotalPendingItem() async {
    for(OrderModel order in orders){
      if(order.status == "50"){
        _totalprocessingItem = _totalprocessingItem + 1;
      }
    }
    notifyListeners();
  }

  //get total sold item
  getTotalSoldItem() async {
    for(OrderModel order in orders){
      if(order.status == "100"){
        _totalSoldItem = _totalSoldItem + 1;
      }
    }
    notifyListeners();
  }

  //get total cancel item
  getTotalCancelItem() async {
    for(OrderModel order in orders){
      if(order.status == "-100"){
        _totalCancelItem = _totalCancelItem + 1;
      }
    }
    notifyListeners();
  }


  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }

  Future<bool> removeFromCart({Map cartItem}) async {
    print("THE PRODUC IS: ${cartItem.toString()}");
    try {
      _userServices.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<void> _onStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
      await getOrders();
      await getTotalSale();
      await getTotalPendingItem();
      await getTotalSoldItem();
      await getTotalOrdered();
      await getTotalCancelItem();
      await getAllUser();

    } else {
      _user = firebaseUser;
      _status = Status.Authentiated;
      _userModel = await _userServices.getUserById(firebaseUser.uid);
      await getOrders();
      await getTotalSale();
      await getTotalPendingItem();
      await getTotalSoldItem();
      await getTotalOrdered();
      await getTotalCancelItem();
      await getAllUser();
    }
    notifyListeners();
  }

  // general metohds
  bool onError(String error) {
    _status = Status.Unauthenticated;
    notifyListeners();
    print("we got an error");
    return false;
  }

  void clearControllers() {
    email.text = "";
    name.text = "";
    password.text = "";
  }

  Future<bool> addToCard(name, price, image, id, quantity) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      //List cart = _userModel.cart;
      bool itemExists = false;
      print(name);
      Map cartItem = {
        "id": cartItemId,
        "name": name,
        "image": image,
        "productId": id,
        "price": price,
        "quantity": quantity
      };
      print("price");
      if (!itemExists) {
        _userServices.addToCart(userId: _user.uid, cartItem: cartItem);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> updateToCard(List cartItem) async {
    try {
      bool itemExists = true;
      if(itemExists) {
        _userServices.updateToCart(userId: _user.uid, cartItem: cartItem);
      }return true;
    } catch (e) {
      return false;
    }
  }
}
