

import 'package:adminpage/services/totalk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AddProductServices{

  Firestore  _firestore = Firestore.instance;
  String ref  = "user_cat";

  void createProduct(String product_name,String catagory,String prices,String discription , String sale) {
    var id = Uuid();
    String product_id = id.v4();
    
    _firestore.collection(ref).document(product_id).setData({
      'id': product_id,
      'name' : product_name,
      'catagory': catagory,
      'price' : prices,
      'qty': 1,
      'discription': discription,
      'sale'  : sale,
    });
  }
}