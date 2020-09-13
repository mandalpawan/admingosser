import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_item.dart';
class UserModel{
  static const NAME = "name";
  static const EMAIL = "email";
  static const ID = "id";
  static const CART="cart";

  //private variable
 String _name;
 String _email;
 String _id;
 List cart;
  int _priceSum = 0;
  int _quantitySum = 0;


  int totalCartPrice;
  //getters
   String get name => _name;
   String get email => _email;
   String get id => _id;


   //constructor
   UserModel.fromsnapshot(DocumentSnapshot snapshot){
     _name = snapshot.data[NAME];
     _email = snapshot.data[EMAIL];
     _id = snapshot.data[ID];
     cart = (snapshot.data[CART] )?? [];
     totalCartPrice = getTotalPrice(cart: snapshot.data[CART]);
   }

  int getTotalPrice({List cart}){

    if(cart == null){
      return 0;
    }
    for(Map cartItem in cart){
      _priceSum += int.parse(cartItem["price"])*cartItem["quantity"];
    }
   int total = _priceSum;
    return total;
  }

 /*List<CartItemModel> _convertCartItems(List cart){
    List<CartItemModel> convertedCart = [];
    for(Map cartItem in cart){
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }*/

}