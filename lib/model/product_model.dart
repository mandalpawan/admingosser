
import 'package:cloud_firestore/cloud_firestore.dart';

class Food{
  String id;
  Timestamp createdAt;
  Timestamp updatedAt;
  String Name;
  String price;
  String stock;
  String category;
  String discription;
  String image;
  String sale;
  String quantity;

  Food();

  Food.fromMap(Map<String, dynamic> data){
    id = data["id"];
    Name = data["Name"];
    sale = data["sale"];
    price = data["price"];
    image = data["image"];
    category = data["category"];
    discription = data["discription"];
    createdAt = data["createdAt"];
    updatedAt = data["updatedAt"];
    stock = data['stock'];
    quantity = data['quantity'];
  }

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      'Name':Name,
      'sale': sale,
      'price': price,
      'category': category,
      'discription': discription,
      'image':image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'qty' : 1,
      'stock':stock,
      'quantity':quantity,
    };
  }

}



















