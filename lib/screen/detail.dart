

import 'package:adminpage/model/Product.dart';
import 'package:adminpage/provider/app.dart';
import 'package:adminpage/provider/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';


class ProductDetail extends StatefulWidget {
  final name;
  final price;
  final image;
  final category;
  final id;
  ProductDetail(this.name,this.price,this.image,this.category,this.id);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  ProductModel pro;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackbar(){
    print("Item Added to Cart");
    final snackBar = new SnackBar(content: new Text("Item added to cart"),
      duration: new Duration(seconds: 3),
      backgroundColor: Colors.red,
    );
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }
  int _valu = 1;
  int prod_total_price=0;
  void add(){
    setState(() {
      _valu+=1;
    });
  }
  void sub(){
    setState(() {
      if(_valu==1){
      }else {
        _valu -= 1;
      }});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Product Detail"),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'btn1',
            onPressed: (){

            },
            child: Icon(Icons.edit),
            foregroundColor: Colors.white,
          ),

          SizedBox(height: 20.0,),

          FloatingActionButton(
            heroTag: 'btn2',
            onPressed: () {},
            child: Icon(Icons.delete),
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
        ],
      ),

      key: _scaffoldkey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.zero,topRight: Radius.zero,bottomLeft: Radius.circular(120),bottomRight: Radius.circular(120)),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 250.0,
                color: Colors.green,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 5.0,
                      right: 110.0,
                      child: CircleAvatar(
                        maxRadius: (70.0),
                        backgroundImage: NetworkImage(widget.image),
                        /*child: Image.network(
                          widget.products_detail_picture,
                          height: 450.0,
                          width: 450.0,
                        ),*/
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            Text(
              widget.name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15.0,),
            Text(
               widget.category,
              style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            ),
            SizedBox(height: 15.0,),
            Text(
              "1kg \t Rs50",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey
              ),
            ),
            SizedBox(height: 15.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and"
                    " typesetting industry. Lorem Ipsum has "
                    "been the industry's standard dummy text"
                    " ever since the 1500s, when an unknown  ",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
