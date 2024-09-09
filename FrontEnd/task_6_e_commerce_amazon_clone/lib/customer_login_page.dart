import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/customer_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/customer_home.dart';
import 'package:task_6_e_commerce_amazon_clone/customer_signup_page.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_home.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_signup_page.dart';
import 'package:tuple/tuple.dart';

class CustomerLoginPage extends ConsumerStatefulWidget{


  @override
  ConsumerState<CustomerLoginPage> createState() => CustomerLoginPageState();

}

class CustomerLoginPageState extends ConsumerState<CustomerLoginPage>{

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool visibility = true;

  void setVisibility(){
    setState(() {
      visibility = !visibility;
    });
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
        body:Stack(
            children: [
              Transform.translate(offset: Offset(0,-50),
                child:Image.asset('images/amazon-png-logo-vector-6695.png'),
              ),

              Padding(
                  padding: const EdgeInsets.only(top: 155,left: 30),
                  child:Column(
                      children:[
                        const Text('Login',
                            style:TextStyle(
                              fontFamily: 'Ember',
                              fontSize: 45,
                            )),

                        Container(
                          height: 50,
                          width: 30,
                        ),



                        Transform.translate(
                            offset: Offset(-10,0),
                            child:const Column(
                                children:[ Text('Email',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontFamily: 'Ember Light',
                                  ),
                                ),



                                ]
                            )
                        ),



                      ]
                  )
              ),

              Padding(
                padding: EdgeInsets.only(top:330,left: 30,right: 30),
                child:TextField(
                  controller: emailController,
                  style: TextStyle(
                    fontFamily: 'Ember Light',
                  ),
                  decoration: InputDecoration(
                      hintText: 'Email' ,
                      hintStyle: TextStyle(fontFamily: 'Ember Light',fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),

                      )

                  ),
                ),
              ),

               Padding(
                padding: EdgeInsets.only(top:400,left: 30,right: 30),
                child:Row(
                  children: [
                    Text('Password',
                      style: TextStyle(
                        fontFamily: 'Ember Light',
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(width: 130,),

                    GestureDetector(
                      onTap: setVisibility,
                      child: Icon(Icons.remove_red_eye,size: 30,),
                    )
                  ],
                )
              ),

              Padding(
                padding: EdgeInsets.only(top:460,left: 30,right: 30),
                child:TextField(
                  obscureText: visibility,
                  controller: passController,
                  style: TextStyle(
                    fontFamily: 'Ember Light',
                  ),
                  decoration: InputDecoration(
                      hintText: 'Password' ,
                      hintStyle: TextStyle(fontFamily: 'Ember Light',fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),

                      )

                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 550,left: 30,right: 30),
                child:Container(
                    width: 350,
                    height: 100,
                    child:ElevatedButton(
                        onPressed: _loginCustomer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE4C083),

                        ),
                        child: const Text('Login',
                          style: TextStyle(
                            fontFamily: 'Ember Light',
                            fontSize: 35,
                            color: Colors.black,
                          ),
                        )

                    )
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 660),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?',
                      style: TextStyle(fontFamily: 'Ember',
                          fontSize: 17),
                    ),

                    Container(
                      height: 0,
                      width: 10,
                    ),

                    GestureDetector(
                      onTap: (()=>{
                        Navigator.push(context,MaterialPageRoute(builder: (context)=> CustomerSignupPage()))
                      }),
                      child: Text('Crate one now !',
                        style: TextStyle(fontFamily: 'Emeber',
                            fontSize: 17,
                            color: Color(0xFFE4C083)),),
                    )
                  ],
                ),
              )
            ]
        )
    );
  }


  void _loginCustomer () async{

    String? email = emailController.text.toString();
    String? pass = passController.text.toString();

    final controller = CustomerController();
    bool result = await controller.LoginCustomer(email, pass);
    if(result==true){
      ref.read(customerEmailProvider.state).state = email;
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerHome()));
    }
    else{
      print("Could not login");
    }

  }

}
