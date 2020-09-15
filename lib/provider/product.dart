
import 'package:adminpage/model/Product.dart';
import 'package:adminpage/services/ProductServices.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier{
  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productsSearched = [];
  //List<ProductModel> productsSearched = [];


  ProductProvider.initialize(){
    loadProducts();
    search(productName: "L");
  }

  loadProducts()async{
    products = await _productServices.getProducts();
    notifyListeners();
  }

  Future search({String productName})async{
       productsSearched = await _productServices.searchProducts(productName: productName);
       notifyListeners();
  }

}