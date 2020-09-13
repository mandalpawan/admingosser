import 'package:adminpage/model/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class OrderServices {
  String collection = "orders";
  Firestore _firestore = Firestore.instance;

  // create users function
  void createOrder(String userId,String id,List cart,int totalprice,String status,String description,String name,String phone,String pin
      ,String home,String road,String land,String city) {
    _firestore.collection(collection).document(id).setData({
      "userId":userId,
      "id":id,
      "cart":cart,
      "total":totalprice,
      "createdAt":DateTime.now().millisecondsSinceEpoch,
      "status":status,
       "description":description,
      "name":name,
      "phone":phone,
      "pin":pin,
      "home":home,
      "road":road,
      "land":land,
      "city":city,
    });
  }

  Future<List<OrderModel>> getUserOrders({String userId}) async =>
      _firestore
          .collection(collection)
          .where("userId", isEqualTo: userId)
          .getDocuments()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.documents) {
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });


}
