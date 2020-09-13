/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebasket/model/cart.dart';
import 'package:ebasket/model/cart_item.dart';
import 'package:ebasket/provider/app.dart';
import 'package:ebasket/provider/cart.dart';
import 'package:ebasket/provider/carts.dart';
import 'package:ebasket/provider/carts.dart';
import 'package:ebasket/provider/carts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:ebasket/services/totalk.dart';

class cartOrder extends StatefulWidget {
  cartOrder();

  @override
  _cartOrderState createState() => _cartOrderState();
}

class _cartOrderState extends State<cartOrder> {
  CartItemModel pro;
  int total = 0;
  int totall = 0;
  int jode = 0;
  int qtyis = 0;

  void update_qty(int product_qty, int product_price) {
    // setState(() {
    total += product_qty * product_price;
    // });

    print(total);
  }

  void updat_qty() {
    print("hi");
  }
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text("Your Cart", style: TextStyle(color: Colors.black)),
        ),
        bottomNavigationBar: Container(
          height: 250.0,
          margin: EdgeInsets.only(top: 20.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total Amount ",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "hi",
                      //  cartProvider.userModel.totalamount.toString(),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Discount",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "5.0",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Tax ",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "10.0",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 35.0,
                  color: Color(0xFFD3D3D3),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Sub Amount",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "50.0",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 500.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Center(
                      child: Text(
                        "Process to Checkout",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body:appProvider.isLoading
            ? Loading()
            :Container(
              child: ListView.builder(
                itemCount: cartProvider.products.length,
                itemBuilder: (_, index) {
                  return ;
                }),
            ),
    );

  }
}

class cart_use extends StatelessWidget {
  final CartItemModel product;
  const cart_use({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return  Card(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 75.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2.0, color: Color(0xFFD3D3D3)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    //add();
                                  },
                                  child: Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Color(0xFFD3D3D3),
                                  ),
                                ),
                                Text(
                                //  "${product.totalamount}",
                                  "${product.quantity}",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Color(0xFFD3D3D3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                         Container(
                            height: 70.0,
                            width: 70.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("${product.image}"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(35.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 5.0,
                                    offset: Offset(5.0, 5.0)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${product.name}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 6.0,
                              ),
                              Text(
                                "hi",
                                style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              SizedBox(height: 25.0,),
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  //_buildTotalAmountContainer(total),
                ],
              ),
            ),
          ],
        ),
      );
  }
}*/
