import 'package:adminpage/model/order.dart';
import 'package:adminpage/provider/auth.dart';
import 'package:adminpage/provider/product_notifier.dart';
import 'package:adminpage/screen/admin_add_product.dart';
import 'package:adminpage/screen/cancel_order.dart';
import 'package:adminpage/screen/explore.dart';
import 'package:adminpage/screen/login.dart';
import 'package:adminpage/screen/order.dart';
import 'package:adminpage/screen/pending.dart';
import 'package:adminpage/screen/product_detail.dart';
import 'package:adminpage/screen/product_list.dart';
import 'package:adminpage/screen/sold.dart';
import 'package:adminpage/services/order.dart';
import 'package:adminpage/services/product_adding.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

enum Page { dashboard, manage }

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.green;
  MaterialColor notActive = Colors.grey;
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();

  @override
  void initState() {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context, listen: false);
    getFoods(foodNotifier);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.dashboard);
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: _selectedPage == Page.dashboard
                            ? active
                            : notActive,
                      ),
                      label: Text('Dashboard'))),
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.manage);
                      },
                      icon: Icon(
                        Icons.sort,
                        color:
                        _selectedPage == Page.manage ? active : notActive,
                      ),
                      label: Text('Manage'))),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: _loadScreen());
  }

  Widget _loadScreen() {

    final user = Provider.of<AuthProvider>(context);
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);


    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[
            ListTile(
              subtitle: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "\u20B9 \t"+user.totalSale.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30.0, color: Colors.green
                  ),
                ),
              ),
              /*
              FlatButton.icon(
                onPressed: null,
                icon: Icon(
                  Icons.attach_money,
                  size: 30.0,
                  color: Colors.green,
                ),
                label: Text(user.totalSale.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0, color: Colors.green)),
              ),*/
              title: Text(
                'Revenue',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, color: Colors.grey),
              ),
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.people_outline),
                              label: Text("Users")),
                          subtitle: Text(
                            user.allUser.length.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: active, fontSize: 50.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context){
                            return processing();
                          }
                        ));
                      },
                      child: Card(
                        child: ListTile(
                            title: FlatButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.category),
                                label: Text("Process")),
                            subtitle: Text(
                              user.totalprocessingItem.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 50.0),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context){
                              return AdminFoodDetailScreen();
                            }
                        ));
                      },
                      child: Card(
                        child: ListTile(
                            title: FlatButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.track_changes),
                                label: Text("Products")),
                            subtitle: Text(
                              foodNotifier.foodList.length.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 50.0),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context){
                            return sold();
                          }
                        ));
                      },
                      child: Card(
                        child: ListTile(
                            title: FlatButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.tag_faces),
                                label: Text("Sold")),
                            subtitle: Text(
                              user.totalSoldItem.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 50.0),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context){
                            return Order();
                          }
                        ));
                      },
                      child: Card(
                        child: ListTile(
                            title: FlatButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.shopping_cart),
                                label: Text("Orders")),
                            subtitle: Text(
                              user.totalOrderedItem.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 50.0),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context){
                            return cancelOrder();
                          }
                        ));
                      },
                      child: Card(
                        child: ListTile(
                            title: FlatButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.close),
                                label: Text("Return")),
                            subtitle: Text(
                              user.totalCancelItem.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 50.0),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add product"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context){
                    return AddfooditemAdmin(isUpdating: false,);
                  }
                ));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.change_history),
              title: Text("Products list"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context){
                    return AdminFoodDetailScreen();
                  }
                ));
              },
            ),
            Divider(),
            GestureDetector(
              onTap: () async {
                user.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => loginPage()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Text(
                    "Logout",
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
        );
        break;
      default:
        return Container();
    }
  }

}