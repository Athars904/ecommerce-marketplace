import 'package:flutter/material.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/seller_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/seller_model.dart';
import 'package:task_6_e_commerce_amazon_clone/nav_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SellerEditProfile extends ConsumerStatefulWidget {
  @override
  ConsumerState<SellerEditProfile> createState() => SellerEditProfileState();
}

class SellerEditProfileState extends ConsumerState<SellerEditProfile> {
  TextEditingController EmailController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController BankController = TextEditingController();
  TextEditingController StoreController = TextEditingController();
  TextEditingController PassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var sellerDetails = ref.watch(sellerDetailsProvider);
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 40),
        title: Image.asset('images/PngItem_12080.png', height: 38),
        centerTitle: true,
        backgroundColor: Color(0XFF232F3E),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.camera_alt,
                size: 40,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: sellerDetails.when(
        data: (seller) {
          return Padding(
            padding: EdgeInsets.only(left: 30, top: 10),
            child: ListView(
              children: [
                const Text(
                  'Email',
                  style: TextStyle(
                    fontFamily: 'Ember Light',
                    fontSize: 40,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: TextField(
                    controller: EmailController,
                    style: TextStyle(
                      fontFamily: 'Ember Light',
                    ),
                    decoration: InputDecoration(
                      hintText:seller?.Email?? 'Email',
                      hintStyle: TextStyle(
                        fontFamily: 'Ember Light',
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Full Name',
                  style: TextStyle(
                    fontFamily: 'Ember Light',
                    fontSize: 40,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: TextField(
                    controller: NameController,
                    style: TextStyle(
                      fontFamily: 'Ember Light',
                    ),
                    decoration: InputDecoration(
                      hintText: seller?.Name?? 'Full Name',
                      hintStyle: TextStyle(
                        fontFamily: 'Ember Light',
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Phone Number',
                  style: TextStyle(
                    fontFamily: 'Ember Light',
                    fontSize: 40,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: TextField(
                    controller: PhoneController,
                    style: TextStyle(
                      fontFamily: 'Ember Light',
                    ),
                    decoration: InputDecoration(
                      hintText: seller?.Phone?? 'Phone Number',
                      hintStyle: TextStyle(
                        fontFamily: 'Ember Light',
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Bank Number',
                  style: TextStyle(
                    fontFamily: 'Ember Light',
                    fontSize: 40,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: TextField(
                    controller: BankController,
                    style: TextStyle(
                      fontFamily: 'Ember Light',
                    ),
                    decoration: InputDecoration(
                      hintText: seller?.BankAccount?? 'Bank Number',
                      hintStyle: TextStyle(
                        fontFamily: 'Ember Light',
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Store Name',
                  style: TextStyle(
                    fontFamily: 'Ember Light',
                    fontSize: 40,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: TextField(
                    controller: StoreController,
                    style: TextStyle(
                      fontFamily: 'Ember Light',
                    ),
                    decoration: InputDecoration(
                      hintText: seller?.StoreName?? 'Store Name',
                      hintStyle: TextStyle(
                        fontFamily: 'Ember Light',
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Password',
                  style: TextStyle(
                    fontFamily: 'Ember Light',
                    fontSize: 40,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: TextField(
                    controller: PassController,
                    style: TextStyle(
                      fontFamily: 'Ember Light',
                    ),
                    decoration: InputDecoration(
                      hintText: '*********',
                      hintStyle: TextStyle(
                        fontFamily: 'Ember Light',
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const Text(
                  '*Password must be at least 6 characters long',
                  style: TextStyle(
                    fontFamily: 'Ember Light',
                    fontSize: 15,
                  ),
                ),
                const Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontFamily: 'Ember Light',
                    fontSize: 40,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: TextField(
                    style: TextStyle(
                      fontFamily: 'Ember Light',
                    ),
                    decoration: InputDecoration(
                      hintText: '*********',
                      hintStyle: TextStyle(
                        fontFamily: 'Ember Light',
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Container(
                    height: 80,
                    child: ElevatedButton(
                      onPressed: () async {
                        print(EmailController.text.toString());
                        print(NameController.text.toString());
                        print(PhoneController.text.toString());
                        print("store name");
                        print(StoreController.text.toString());

                        Seller newSeller = Seller(Name: NameController.text.toString(), Email: seller!.Email, BankAccount:
                            BankController.text.toString(), Phone: PhoneController.text.toString(), Password: PassController.text.toString(), StoreName: StoreController.text.toString());


                        String email = EmailController.text.toString();

                        SellerController sellerController = SellerController();
                        bool result = await sellerController.updateSeller(newSeller, email);


                        if(result){
                        if(EmailController.text.toString()!=''){
                            ref.read(sellerEmail.state).state = EmailController.text.toString();
                        }
                        ref.refresh(sellerDetailsProvider);
                        Navigator.pop(context);
                        }
                        else{
                          print("error occured while updating data");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color((0xFFFF9900)),
                      ),
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontFamily: 'Ember Light',
                          fontSize: 35,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text('Error: $error'),
          );
        },
        loading: () {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
