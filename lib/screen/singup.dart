








import 'package:adminpage/provider/auth.dart';
import 'package:adminpage/screen/load_screen.dart';
import 'package:adminpage/screen/login.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class signUpPage extends StatefulWidget {
  @override
  _signUpPageState createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _key,
      backgroundColor: Colors.white,
      body:authProvider.status == Status.Authenticating? Loading() :
      Container(
        padding: EdgeInsets.symmetric(horizontal: 19.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(height:40.0,),
            Expanded(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sign Up", style: TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'sfpro'
                  ),),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller:authProvider.name,
                    decoration: InputDecoration(
                      labelText: "Name",
                    ),
                  ),

                  TextFormField(
                    controller: authProvider.email,
                    decoration: InputDecoration(
                      labelText: "Mail ID",
                    ),
                  ),
                  TextFormField(
                    controller: authProvider.password,
                    validator: (val) =>
                    val.length != 6  ? 'minimum six charachter required' :null ,
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                  ),
                  SizedBox(height: 30,),
                  GestureDetector(
                    onTap: ()async {
                      var result = await Connectivity().checkConnectivity();
                      if (result == ConnectivityResult.none) {
                        authProvider.clearControllers();

                      } else if (result == ConnectivityResult.mobile) {
                        if (!await authProvider.signUp()) {
                          _key.currentState.showSnackBar(
                              SnackBar(content: Text("Registration failed"))
                          );
                          return;
                        }
                        authProvider.clearControllers();
                        //changeScreen(context, loginPage());
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context){
                            return  loginPage();
                          }
                        ));
                      } else if (result == ConnectivityResult.wifi) {
                        if (!await authProvider.signUp()) {
                          _key.currentState.showSnackBar(
                              SnackBar(content: Text("Registration failed due to short password or invalid email"))
                          );

                          return;
                        }
                        authProvider.clearControllers();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context){
                              return  loginPage();
                            }
                        ));
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
                        child: Text("SIGN UP", style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'sfpro'
                        ),),
                      ),
                    ),
                  ),
                  /*SizedBox(height: 10,),
                  Text("By pressing signup you agree to our terms and conditions", style: TextStyle(
                      fontSize: 15
                  ),textAlign: TextAlign.center,)*/
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child:  Text("Already have an account?", style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'sfpro'
                      ),),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child:  GestureDetector(
                        onTap: openLoginPage,
                        child: Text("LOGIN", style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /* Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?", style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'sfpro'
                ),),
                InkWell(
                  onTap: openLoginPage,
                  child: Text(" LOGIN", style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                  ),),
                )
              ],
            ),*/
          ],
        ),
      ),
    );
  }
  void openLoginPage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>loginPage()));
  }
}