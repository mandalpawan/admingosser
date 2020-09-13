import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class price extends ChangeNotifier{
 int realtimeprice=15;
 List<Productw> _product = [];
 price(){
  Firestore.instance.collection("Add_to_Cart").getDocuments().then((QuerySnapshot snapshot){
    snapshot.documents.forEach((DocumentSnapshot doc) {
      _product=doc.data as List<Productw>;
    });
  });

}
void addnkl(int product_qty,int product_price){
   realtimeprice+=product_qty+product_price;
  notifyListeners();
}
  List<Productw> get producty => _product;

}
class Productw {
  final product_Name;
  final product_image;
  final product_price;
  final product_qty;
  Productw(this.product_Name,this.product_image,this.product_price,this.product_qty);
}
