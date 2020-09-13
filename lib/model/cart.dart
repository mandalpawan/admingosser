

class Food {
  int product_price;
  String product_Name;
  int product_qty;
  String product_image;


  Food();

  Food.fromMap(Map<String, dynamic> data){
    product_price = data["product_price"];
    product_Name = data["product_Name"];
    product_qty = data["product_qty"];
    product_image = data["product_image"];
  }

  Map<String, dynamic> toMap(){
    return {
      "product_price": product_price,
      'product_Name':product_Name,
      'product_qty': product_qty,
      'product_image': product_image,
    };
  }

}