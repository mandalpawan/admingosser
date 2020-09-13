import 'package:adminpage/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserServices {
  String collection = "users";
  Firestore _firestore = Firestore.instance;

  // create users function
  void createUsers(Map<String, dynamic> values) {
    String id = values["id"];
    _firestore.collection(collection).document(id).setData(values);
  }

  // update data function
  void updateUserData(Map<String, dynamic> values){
    _firestore.collection(collection).document(values["id"]).updateData(values);
  }

  //adding to cart

  void addToCart({String userId,Map cartItem}){
    _firestore.collection(collection).document(userId).updateData({
      "cart":FieldValue.arrayUnion([cartItem])
    });
  }

  void updateToCart({String userId,List cartItem}){
    _firestore.collection(collection).document(userId).updateData({
      "cart":cartItem
    });
  }

  void removeFromCart({String userId,Map cartItem}){
    print("THE USER ID IS: $userId");
    print("cart items are: ${cartItem.toString()}");
    _firestore.collection(collection).document(userId).updateData({
      "cart": FieldValue.arrayRemove([cartItem])
    });
  }

  // fetch user data
  Future<UserModel>  getUserById(String id)=>_firestore.collection(collection).document(id).get().then((doc){
    return UserModel.fromsnapshot(doc);
  });

}
