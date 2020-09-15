import 'package:adminpage/provider/product_notifier.dart';
import 'package:adminpage/screen/product_detail.dart';
import 'package:adminpage/services/product_adding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminFoodDetailScreen extends StatefulWidget {
  @override
  _AdminFoodDetailScreenState createState() => _AdminFoodDetailScreenState();
}

class _AdminFoodDetailScreenState extends State<AdminFoodDetailScreen> {


  @override
  void initState() {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context, listen: false);
    getFoods(foodNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.green,
          title: Text("Product Items"),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView.separated(
          itemBuilder: (BuildContext context,int index){
            return ListTile(
              leading: Image.network(
                foodNotifier.foodList[index].image != null ?
                foodNotifier.foodList[index].image : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                width: 120,
                fit: BoxFit.fitWidth,
              ),
              title: Text(foodNotifier.foodList[index].Name),
              subtitle: Text("Hello"),
              onTap: (){
                foodNotifier.currentFood = foodNotifier.foodList[index];

                Navigator.of(context).push(MaterialPageRoute
                  (builder:  (BuildContext context)=>ShowAdminFoodDetail())
                );
              },
            );
          },

          separatorBuilder: (BuildContext context,int index){
            return Divider(
              height: 0.0,
            );
          },
          itemCount: foodNotifier.foodList.length,
        ),
      ),
    );
  }
}