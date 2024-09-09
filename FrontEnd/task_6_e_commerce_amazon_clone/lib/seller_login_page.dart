import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_home.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_signup_page.dart';
import 'package:tuple/tuple.dart';

class SellerLoginPage extends ConsumerStatefulWidget{


  @override
  ConsumerState<SellerLoginPage> createState() => SellerLoginPageState();

}

class SellerLoginPageState extends ConsumerState<SellerLoginPage>{

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool isLoggingIn = false;

  bool visibility = true;

  void setVisibility(){
    setState(() {
      visibility = !visibility;
    });
  }

  _loginSeller(){
    setState(() {
      isLoggingIn = true;
    });
  }

  @override
  Widget build(BuildContext context){
    if(isLoggingIn){
      Tuple2<String,String> tuple = Tuple2(emailController.text.toString(), passController.text.toString());

      ref.listen<AsyncValue<bool>>(SellerLoginProvider(tuple), (previous, next) {
        next.when(
          data: (data)   {
            //print(data);
            if (data) {
              print("seller found and logging in");

              // Set the email state
              final email = emailController.text.toString();
              ref.read(sellerEmail.state).state = email;
              print(ref.read(sellerEmail.state).state);
              Navigator.push(context,MaterialPageRoute(builder: (context)=>SellerHome()));

            }
          },
          loading: () {
            print("loading...");
          },
          error: (error, stackTree) {
            print("Some error occurred");
          },
        );
      });



      isLoggingIn= false;

    }

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
                const Text('Password',
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
                  onPressed: _loginSeller,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF9900),

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
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> SellerSignupPage()))
                  }),
                  child: Text('Crate one now !',
                  style: TextStyle(fontFamily: 'Emeber',
                  fontSize: 17,
                  color: Color(0xFFFF9900)),),
                )
              ],
            ),
          )
        ]
      )
    );
  }
}
