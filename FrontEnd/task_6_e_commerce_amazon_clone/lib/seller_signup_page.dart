import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_home.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_login_page.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_profile.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/seller_model.dart';

class SellerSignupPage extends ConsumerStatefulWidget{
  @override
  ConsumerState<SellerSignupPage> createState() => SellerSignupPageState();

}

class SellerSignupPageState extends ConsumerState<SellerSignupPage>{
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController storeController = TextEditingController();
  TextEditingController confirmController = TextEditingController();


  bool isSigningUp = false;

  bool visibility1 = true;
  bool visibility2 = true;

  void setVisibility1(){
    setState(() {
      visibility1 = !visibility1;
    });
  }




  //late Seller seller ;

  _signUp(){
    setState(() {
      isSigningUp=true;
    });

  }

  @override
  Widget build(BuildContext context){
    if(isSigningUp){

      if(confirmController.text == passController.text){

        Seller seller = Seller(
            Name:nameController.text.toString(),
            Email: emailController.text.toString(),
            BankAccount: bankController.text.toString(),
            Phone: phoneController.text.toString(),
            Password: passController.text.toString(),
            StoreName: storeController.text.toString()
        );

        ref.listen(SellerSignupProvider(seller),(previous,next){
          next.when(
              data: (data){
                print(data);
                if(data){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>SellerLoginPage()));
                }
              },
              loading: (){
                print("loading...");
              },
              error: (error,stackTree){
                print("An error occured");
              }
          );
        });
      }

      isSigningUp=false;
    }

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

                const Text('Bank Number',style: TextStyle(
                  fontFamily: 'Ember Light',
                  fontSize: 40,
                ),),

                Padding(
                  padding: EdgeInsets.only(right:30),
                  child:TextField(
                    controller: bankController,
                    style: TextStyle(
                      fontFamily: 'Ember Light',
                    ),
                    decoration: InputDecoration(
                        hintText: 'Bank Number' ,
                        hintStyle: TextStyle(fontFamily: 'Ember Light',fontSize: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),

                        )

                    ),
                  ),
                ),

                const Text('Store Name',style: TextStyle(
                  fontFamily: 'Ember Light',
                  fontSize: 40,
                ),),

                Padding(
                  padding: EdgeInsets.only(right:30),
                  child:TextField(
                    controller: storeController,
                    style: TextStyle(
                      fontFamily: 'Ember Light',
                    ),
                    decoration: InputDecoration(
                        hintText: 'Store Name' ,
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
                       onTap: setVisibility1,
                       child: Icon(Icons.remove_red_eye,size: 30,),
                     )
                   ],
                 ),

                Padding(
                  padding: EdgeInsets.only(right:30),
                  child:TextField(
                    obscureText: visibility1,
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

                 Row(
                   children: [
                     Text('Confirm Password',style: TextStyle(
                       fontFamily: 'Ember Light',
                       fontSize: 40,
                     ),),
]
    ),

                Padding(
                  padding: EdgeInsets.only(right:30),
                  child:TextField(
                    controller: confirmController,
                    obscureText: visibility1,
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
                          onPressed: _signUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color((0xFFFF9900)),

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
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>SellerLoginPage()))
                  }),
                  child:Text(
                    'Login Now!',
                    style:TextStyle(
                      color: Color(0xFFFF9900),
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

}