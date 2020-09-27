import 'package:adminpage/model/order.dart';
import 'package:adminpage/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class sold extends StatefulWidget {
  @override
  _soldState createState() => _soldState();
}

class _soldState extends State<sold> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AuthProvider>(context);


    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        title: Text("Sold product"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(

        child: Container(
          child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: user.orders.length,
              itemBuilder: (_, index){
                OrderModel _order = user.orders[index];

                if(user.orders[index].status ==100.toString()){
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
                                    'Name : Pawan Mandal'
                                ),
                                SizedBox(height: 5.0,),
                                Text(
                                    'Mobile Number : 8603587194'
                                ),
                                SizedBox(height: 5.0,),
                                Text(
                                    'Table No. : 05'
                                ),
                                SizedBox(height: 10.0,),
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
