import 'package:adminpage/provider/app.dart';
import 'package:adminpage/provider/auth.dart';
import 'package:adminpage/provider/product.dart';
import 'package:adminpage/provider/product_notifier.dart';
import 'package:adminpage/screen/admin_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: ProductProvider.initialize()),
    //ChangeNotifierProvider.value(value: CartProvider.initialize()),
    ChangeNotifierProvider.value(value: AuthProvider.initialize()),
    ChangeNotifierProvider.value(value: AppProvider()),
    ChangeNotifierProvider(
      create: (context) => FoodNotifier(),
    ),

  ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'admin ',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Admin(),
    );
  }
}


