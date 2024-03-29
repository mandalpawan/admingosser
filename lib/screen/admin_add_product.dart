import 'dart:io';

import 'package:adminpage/model/product_model.dart';
import 'package:adminpage/provider/product_notifier.dart';
import 'package:adminpage/screen/loading_page.dart';
import 'package:adminpage/services/product_adding.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';



class AddfooditemAdmin extends StatefulWidget {

  final bool isUpdating;

  AddfooditemAdmin({@required this.isUpdating});

  @override
  _AddfooditemAdminState createState() => _AddfooditemAdminState();
}

class _AddfooditemAdminState extends State<AddfooditemAdmin> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Food _currentFood;
  String _imageUrl;
  File _imageFile;

  var _FoodListCatagory = ["vegetables", "fruits","dry fruits","cerealas","pulses","spices","dairy products","bakery products","eggs & chicken","mahila gruhudyog products","oil"];

  var _FoodListSale = ["Regular", "Not Regular"];

  var _FoodQunantitySale = [" 1/Kg ", " 1/Lit "];

  var _currentFoodCatagoryList = "vegetables";
  var _currentFoodSaleList = "Not Regular" ;
  var _currentFoodQunatityList = " 1/Kg " ;

  @override
  void initState(){
    super.initState();
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context , listen: false);

    if(foodNotifier.currentFood != null){
      _currentFood = foodNotifier.currentFood;
    }else{
      _currentFood = Food();
    }
    _imageUrl = _currentFood.image;

  }


  Widget _showImage(){
    if (_imageFile == null && _imageUrl == null) {
      return SizedBox();
      print("No image found");

    } else if(_imageFile != null){
      print("Showing Image from file");

      return Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Image.file(
            _imageFile,
            fit: BoxFit.cover,
            height: 250.0,
          ),
          FlatButton(
            child: Text(
              "Change Image",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
            onPressed: ()=> _getLocalImage(),
          ),
        ],
      );

    }else if(_imageUrl!= null){
      print("Showing Image from url");

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(_imageUrl,
            fit: BoxFit.cover,
            height: 250.0,
          ),
          FlatButton(
            padding: EdgeInsets.all(16.0),
            color: Colors.black54,
            child: Text(
              "Change Image",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22.0),
            ),
            onPressed: ()=> _getLocalImage(),
          ),
        ],
      );
    }
  }

  _getLocalImage() async{
    File imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 400,
    );
    if(imageFile != null){
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  _onFoodUploaded(Food food) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context, listen: false);
    foodNotifier.addFood(food);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  Widget _buildNameField(){
    return TextFormField(
      initialValue: _currentFood.Name,
      decoration: InputDecoration(labelText: "Name"),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 18.0),
      validator: (String value){
        if(value.isEmpty){
          return "Name field is required";
        }
        if(value.length<3 || value.length>20){
          return "Name must be less then 3 and less the 20";
        }
        return null;
      },
      onSaved: (String value){
        _currentFood.Name = value;
      },
    );
  }

  Widget _buildOnSaleField(){
    return Container(
      child: DropdownButtonFormField<String>(
        items: _FoodListSale.map((String dropDownItem){
          return DropdownMenuItem<String>(
            value: dropDownItem,
            child: Text(dropDownItem),
          );
        }).toList(),
        decoration: InputDecoration(labelText: "OnSale",),
        onChanged: (String value) {
          setState(() {
            _currentFoodSaleList = value;
          });
        },
        value: _currentFoodSaleList,
        onSaved: (String value){
          _currentFood.sale =value;
        },
      ),
    );

  }

  Widget _buildCatagoryField(){
    return Container(
      child: DropdownButtonFormField<String>(
        items: _FoodListCatagory.map((String dropDownItem){
          return DropdownMenuItem<String>(
            value: dropDownItem,
            child: Text(dropDownItem),
          );
        }).toList(),
        decoration: InputDecoration(labelText: "Catagory",),

        onChanged: (String value) {
          setState(() {
            _currentFoodCatagoryList = value;
          });
        },
        validator: (String value){

        },
        value: _currentFoodCatagoryList,
        onSaved: (String value){
          _currentFood.category =value;
        },
      ),
    );

  }

  Widget _buildQuantityField(){
    return Container(
      child: DropdownButtonFormField<String>(
        items: _FoodQunantitySale.map((String dropDownItem){
          return DropdownMenuItem<String>(
            value: dropDownItem,
            child: Text(dropDownItem),
          );
        }).toList(),
        decoration: InputDecoration(labelText: "Quantity",),

        onChanged: (String value) {
          setState(() {
            _currentFoodQunatityList = value;
          });
        },
        validator: (String value){

        },
        value: _currentFoodQunatityList,
        onSaved: (String value){
          _currentFood.quantity = value;
        },
      ),
    );

  }

  Widget _buildDiscriptionField(){
    return TextFormField(
      initialValue: _currentFood.discription,
      maxLines: 5,
      decoration: InputDecoration(labelText: "Discription",),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 18.0),
      validator: (String value){
        if(value.isEmpty){
          return "Discription field is required";
        }
        if(value.length<3 || value.length>200){
          return "Discription must be less then 3 and less the 20";
        }
        return null;
      },
      onSaved: (String value){
        _currentFood.discription = value;
      },
    );
  }

  Widget _buildPriceField(){
    return TextFormField(
      initialValue: _currentFood.price,
      decoration: InputDecoration(labelText: "Price"),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 18.0),
      validator: (String value){
        if(value.isEmpty){
          return "Price field is required";
        }
        if(value.length>3){
          return "";
        }
        return null;
      },
      onSaved: (String value){
        _currentFood.price = value;
      },
    );
  }
  Widget _buildstockField(){
    return TextFormField(
      initialValue: _currentFood.price,
      decoration: InputDecoration(labelText: "Stock"),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 18.0),
      validator: (String value){
        if(value.isEmpty){
          return "Stock field is required";
        }
        if(value.length>3){
          return "";
        }
        return null;
      },
      onSaved: (String value){
        _currentFood.stock = value;
      },
    );
  }


  _saveFood(){
    if(!_formkey.currentState.validate()){
      return;
    }

    _formkey.currentState.save();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context){
        return LoadingPage();
      }
    ));
    uploadFoodAndImage(_currentFood, widget.isUpdating , _imageFile,_onFoodUploaded);
    //print(_currentFood.price + _currentFoodQunatityList);
   // Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        title: Text(
            "Product Form"
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32.0),
        child: Form(
          key: _formkey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              _showImage(),
              SizedBox(height: 16.0,),
              Text(
                widget.isUpdating ? "Updating Product" : "Add New Product",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0),
              ),
              SizedBox(height: 16.0,),
              _imageFile == null && _imageUrl == null
                  ? ButtonTheme(
                child: RaisedButton(
                  color: Colors.green,
                  onPressed: ()=> _getLocalImage(),
                  child: Text(
                    "Add Image",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
                  :SizedBox(height: 0.0,),

              _buildNameField(),
              _buildCatagoryField(),
              _buildOnSaleField(),
              _buildDiscriptionField(),
              Row(
                children: [
                  Expanded(
                    child: _buildPriceField(),
                  ),
                  SizedBox(width: 30.0,),
                  Expanded(
                    child: _buildQuantityField(),
                  ),

                ],
              ),
              _buildstockField(),
              SizedBox(height: 16.0,),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => _saveFood(),
        child: Icon(Icons.save),
        foregroundColor: Colors.white,
      ),
    );
  }
}
