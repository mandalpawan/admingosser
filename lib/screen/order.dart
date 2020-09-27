import 'package:adminpage/model/order.dart';
import 'package:adminpage/provider/app.dart';
import 'package:adminpage/provider/auth.dart';
import 'package:adminpage/screen/loading_page.dart';
import 'package:adminpage/services/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AuthProvider>(context);
    final appload = Provider.of<AppProvider>(context);

    user.getOrders();

    OrderServices orderService =  OrderServices();

    void _showDialog(String orderid,String status) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Cancel Ordered"),
            content: new Text("Are you suru to cancel order?"),
            actions: <Widget>[
              FlatButton(
                child: new Text("Yes"),
                onPressed: () {
                  orderService.CancelOrder(uid: orderid,status: status);
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        title: Text(
          "Order "
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: appload.isLoading ? LoadingPage() : SingleChildScrollView(

        child: Container(
          child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: user.orders.length,
              itemBuilder: (_, index){
                OrderModel _order = user.orders[index];

                if(user.orders[index].status ==0.toString()){
                  return Column(
                      children:<Widget>[
                        Card(
                          margin: EdgeInsets.all(8.0),
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Order No.\n "+ user.orders[index].id,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0
                                  ),
                                ),


                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: user.orders[index].cart.length,
                                    itemBuilder: (_ , indexs) {
                                      print(user.orders[index].cart[indexs]["name"]);
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(35.0),
                                                  child: Container(
                                                    height: 70.0,
                                                    width: 70.0,
                                                    child: Image.network(
                                                      user.orders[index].cart[indexs]["image"],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10.0,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      user.orders[index].cart[indexs]["name"],
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight: FontWeight.w600
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.0,),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "\u20B9 " + user.orders[index].cart[indexs]["price"],
                                                          style: TextStyle(
                                                              color: Colors.orangeAccent
                                                          ),
                                                        ),
                                                        Text(
                                                            " x "
                                                        ),
                                                        Text(
                                                            user.orders[index].cart[indexs]["quantity"].toString()
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                ),
                                SizedBox(height: 10.0,),
                                Text(
                                  "Total Amount\t\t \u20B9 "+ user.orders[index].total.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0
                                  ),
                                ),
                                SizedBox(height: 8.0,),
                                Text(
                                  "Payment Mode : Cash",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0
                                  ),

                                ),
                                SizedBox(height: 10.0,),
                                Text(
                                  'Delivery Detail :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0
                                  ),
                                ),
                                SizedBox(height: 8.0,),
                                Text(
                                    user.orders[index].name
                                ),
                                SizedBox(height: 5.0,),
                                Text(
                                  user.orders[index].home,
                                ),
                                SizedBox(height: 5.0,),
                                Text(
                                  user.orders[index].road,
                                ),
                                Text(
                                  user.orders[index].land,
                                ),
                                Text(
                                  user.orders[index].city,
                                ),
                                Text(
                                  user.orders[index].pin,
                                ),
                                Text(
                                  "Maharastra",
                                ),
                                Text(
                                  user.orders[index].phone,
                                ),
                                SizedBox(height: 10.0,),

                                Row(
                                  children: [
                                    RaisedButton(
                                      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 19.0),
                                      color: Colors.green,
                                      onPressed: (){
                                        appload.changeIsLoading();
                                        orderService.updateOrder(uid: user.orders[index].id,status: user.orders[index].status);
                                        appload.changeIsLoading();
                                      },
                                      child: Text(
                                        "Add To Process",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: 15.0,),
                                    RaisedButton(
                                      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 19.0),
                                      color: Colors.red,
                                      onPressed: (){
                                        appload.changeIsLoading();
                                        //orderService.updateOrder(uid: user.orders[index].id,status: user.orders[index].status);
                                        _showDialog(user.orders[index].id,user.orders[index].status);
                                        appload.changeIsLoading();
                                      },
                                      child: Text(
                                        "Cancel Order",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                  );
                }else{
                  return SizedBox();
                }


              }
          ),
        ),
      ),
    );
  }
}
