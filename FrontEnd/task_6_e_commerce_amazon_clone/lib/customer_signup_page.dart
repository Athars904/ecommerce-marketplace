import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/customer_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/customer_model.dart';
import 'package:task_6_e_commerce_amazon_clone/customer_login_page.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_home.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_login_page.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_profile.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/seller_model.dart';

class CustomerSignupPage extends StatefulWidget{
  @override
  State<CustomerSignupPage> createState() => CustomerSignupPageState();

}

class CustomerSignupPageState extends State<CustomerSignupPage>{
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  bool visibility = true;

  void setVisibility(){
    setState(() {
      visibility = !visibility;
    });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 60),
            child:Image.asset('images/amazon-fixed.png'),
          ),




          Expanded(

            child:Padding(
              padding: EdgeInsets.only(left:30),
              // padding: EdgeInsets.only(top: 80,left: 30),
              child: ListView(
                children:  [
                  const Text('Signup',style: TextStyle(
                    fontFamily: 'Ember',
                    fontSize: 40,
                  ),),

                  const Text('Email',style: TextStyle(
                    fontFamily: 'Ember Light',
                    fontSize: 40,
                  ),),

                  Padding(
                    padding: EdgeInsets.only(right: 30),
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


                  const Text('Full Name',style: TextStyle(
                    fontFamily: 'Ember Light',
                    fontSize: 40,
                  ),),

                  Padding(
                    padding: EdgeInsets.only(right:30),
                    child:TextField(
                      controller: nameController,
                      style: TextStyle(
                        fontFamily: 'Ember Light',
                      ),
                      decoration: InputDecoration(
                          hintText: 'Full Name' ,
                          hintStyle: TextStyle(fontFamily: 'Ember Light',fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),

                          )

                      ),
                    ),
                  ),

                  const Text('Phone Number',style: TextStyle(
                    fontFamily: 'Ember Light',
                    fontSize: 40,
                  ),),

                  Padding(
                    padding: EdgeInsets.only(right:30),
                    child:TextField(
                      controller: phoneController,
                      style: TextStyle(
                        fontFamily: 'Ember Light',
                      ),
                      decoration: InputDecoration(
                          hintText: 'Phone Number' ,
                          hintStyle: TextStyle(fontFamily: 'Ember Light',fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),

                          )

                      ),
                    ),
                  ),

                  const Text('Address',style: TextStyle(
                    fontFamily: 'Ember Light',
                    fontSize: 40,
                  ),),

                  Padding(
                    padding: EdgeInsets.only(right:30),
                    child:TextField(
                      controller: addressController,
                      style: TextStyle(
                        fontFamily: 'Ember Light',
                      ),
                      decoration: InputDecoration(
                          hintText: 'Address' ,
                          hintStyle: TextStyle(fontFamily: 'Ember Light',fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),

                          )

                      ),
                    ),
                  ),


                   Row(
                     children: [
                       Text('Password',style: TextStyle(
                         fontFamily: 'Ember Light',
                         fontSize: 40,
                       ),),

                       SizedBox(width: 130,),

                       GestureDetector(
                         onTap: setVisibility,
                         child: Icon(Icons.remove_red_eye,size: 30,),
                       )
                     ],
                   ),
                  Padding(
                    padding: EdgeInsets.only(right:30),
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

                  const Text('*Password must be atleast 6 characters long',style: TextStyle(
                    fontFamily: 'Ember Light',
                    fontSize: 15,
                  ),),

                  const Text('Confirm Password',style: TextStyle(
                    fontFamily: 'Ember Light',
                    fontSize: 40,
                  ),),

                  Padding(
                    padding: EdgeInsets.only(right:30),
                    child:TextField(
                      obscureText: visibility,
                      controller: confirmController,
                      style: TextStyle(
                        fontFamily: 'Ember Light',
                      ),
                      decoration: InputDecoration(
                          hintText: 'Confirm Password' ,
                          hintStyle: TextStyle(fontFamily: 'Ember Light',fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),

                          )

                      ),
                    ),
                  ),

                  Container(
                    height:30,
                    width: 0,
                  ),

                  Padding(
                    padding: EdgeInsets.only(right:30),
                    child:Container(
                        height: 80,
                        child:ElevatedButton(
                            onPressed: _signUpCustomer,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color((0xFFE4C083)),

                            ),
                            child: const Text('Signup',
                              style: TextStyle(
                                fontFamily: 'Ember Light',
                                fontSize: 35,
                                color: Colors.black,
                              ),
                            )

                        )
                    ),
                  ),


                  Transform.translate(offset: Offset(-10,0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Ember'
                              ),
                            ),

                            Container(
                              height: 0,
                              width:5,
                            ),

                            GestureDetector(
                              onTap: (()=>{
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>CustomerLoginPage()))
                              }),
                              child:Text(
                                  'Login Now!',
                                  style:TextStyle(
                                    color: Color(0xFFE4C083),
                                    fontFamily: 'Ember',
                                    fontSize: 17,

                                  )
                              ) ,
                            ),

                            Container(
                              height: 100,
                              width: 0,
                            )
                          ]
                      )
                  )
                ],
              ),
            ),

          )

        ],
      ),
    );
  }

  void _signUpCustomer() async{

    if(confirmController.text == passController.text){

      Customer customer = Customer(
          Name: nameController.text.toString(),
          Email: emailController.text.toString(),
          Address: addressController.text.toString(),
          Phone: phoneController.text.toString(),
          Pass: passController.text.toString());

      final controller = CustomerController();

      bool result = await controller.SignUpCustomer(customer);

      if(result==true){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerLoginPage()));
      }
      else{
        print("Could not create user");
      }
    }



  }

}