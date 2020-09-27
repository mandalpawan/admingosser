


import 'package:adminpage/provider/auth.dart';
import 'package:adminpage/screen/admin_home.dart';
import 'package:adminpage/screen/load_screen.dart';
import 'package:adminpage/screen/singup.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return WillPopScope(
      onWillPop: _onback,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _key,
        backgroundColor: Colors.white,
        body:
        authProvider.status == Status.Authenticating ? Loading() : Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(19),
                  child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/logodss.jpeg',),
                              fit: BoxFit.cover
                          ),
                          color: Colors.green
                      )
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Expanded(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome Back!", style: TextStyle(
                        color: Colors.green,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'sfpro'
                    ),),
                    Text("Please Log In to Your Account", style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: authProvider.email,
                      decoration: InputDecoration(
                        labelText: "Email",
                      ),
                    ),
                    TextFormField(
                      controller: authProvider.password,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                      ),
                    ),

                    SizedBox(height: 30,),
                    InkWell(
                      onTap: ()async{
                        var result = await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.none) {
                          authProvider.clearControllers();

                        } else if (result == ConnectivityResult.mobile) {
                          if(await authProvider.signIn()){
                            authProvider.clearControllers();
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Admin()));
                          }
                          else{
                            //_key.currentState.showSnackBar(SnackBar(content:Text("Please enter correct email-id or password ")));
                            return;
                          }
                        } else if (result == ConnectivityResult.wifi) {
                          if(await authProvider.signIn()){
                            authProvider.clearControllers();
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Admin()));
                          }
                          else{
                            //_key.currentState.showSnackBar(SnackBar(content:Text("Please enter correct email-id or password ")));
                            return;
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            color: Colors.green
                        ),
                        child: Center(
                          child: Text("LOGIN", style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'sfpro'
                          ),),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Center(
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child: Text("OR")
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){

                          },
                          child: Text("Forgot Password?", style: TextStyle(
                              color: Colors.grey
                          ),),
                        ),
                      ],
                    ),
                    SizedBox(height: 19,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?", style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'sfpro'
                        ),),
                        InkWell(
                          onTap: openSignUpPage,
                          child: Text(" SIGN UP", style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                          ),),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void openSignUpPage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>signUpPage()));
  }
  /*void openHomePage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
  }*/
  Future<bool> _onback(){
    Navigator.pop(context,true);
  }
}