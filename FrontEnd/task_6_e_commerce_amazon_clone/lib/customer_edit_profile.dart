import 'package:flutter/material.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/seller_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/customer_model.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/seller_model.dart';
import 'package:task_6_e_commerce_amazon_clone/app_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/nav_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Controllers/customer_controller.dart';

class CustomerEditProfile extends ConsumerStatefulWidget {
  @override
  ConsumerState<CustomerEditProfile> createState() => CustomerEditProfileState();
}

class CustomerEditProfileState extends ConsumerState<CustomerEditProfile> {
  TextEditingController EmailController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  //TextEditingController StoreController = TextEditingController();
  TextEditingController PassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var customerDetails = ref.watch(customerDetailsProvider);
    return Scaffold(
      drawer: NavBar(),
      appBar:CustomAppBar(),
      body: customerDetails.when(
        data: (customer) {
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
                      hintText:customer?.Email?? 'Email',
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
                      hintText: customer?.Name?? 'Full Name',
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
                      hintText: customer?.Phone?? 'Phone Number',
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
                  'Address',
                  style: TextStyle(
                    fontFamily: 'Ember Light',
                    fontSize: 40,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: TextField(
                    controller: AddressController,
                    style: TextStyle(
                      fontFamily: 'Ember Light',
                    ),
                    decoration: InputDecoration(
                      hintText: customer?.Address?? 'Bank Number',
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

                        print(AddressController.text.toString());

                        Customer newCustomer = Customer(Name: NameController.text.toString(), Email: customer!.Email, Address:
                        AddressController.text.toString(), Phone: PhoneController.text.toString(), Pass: PassController.text.toString(),);


                        String email = EmailController.text.toString();

                        CustomerController customerController = CustomerController();
                        bool result = await customerController.updateCustomer(newCustomer, email);


                        if(result){
                          if(EmailController.text.toString()!=''){
                            ref.read(customerEmailProvider.state).state = EmailController.text.toString();
                          }
                          ref.refresh(customerDetailsProvider);
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
