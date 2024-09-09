import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_6_e_commerce_amazon_clone/nav_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/product_model.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/product_controller.dart';

class EditProduct extends ConsumerStatefulWidget{

  @override
  ConsumerState createState() => EditProductState();
}

class EditProductState extends ConsumerState<EditProduct>{

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

//  bool check = true;

  String? selectedDept;
  int? selectedCategory ;

  List<String> ComputersOptions = ['Components', 'Accessories'];
  List<String> BabyOptions = ['Apparel', 'Care'];
  List<String> PersonalOptions = ['Skincare', 'Haircare'];

  Map<String,int> categoryMap = {
    'Components' : 1,
    'Accessories' : 2,
    'Apparel' : 3,
    'Care' : 4,
    'Skincare':5,
    'Haircare':6



  };

  var image;

  bool first = true;

  XFile? selectedImage;
  var imagePicker = ImagePicker();

  bool check = true;

  var newImage;

  Future pickImage() async {
     newImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if(newImage==null){
      return;
    }
    setState(() {
      image = Image.file(File(newImage.path));
      check = false;
    });
  }

  //new image variable


  @override
  Widget build(BuildContext context){
    Product? product = ref.read(productProvider);
    print('product : $product');

    if(first){
      selectedCategory = product?.CategoryID;
      first = false;
    };




    // selectedImage = Image.network(imageUrl);

    var imageUrl;



    if(product?.image!=null && check == true){
       imageUrl = 'http://10.0.2.2:3000/uploads/${product?.image}';
       image = Image.network(imageUrl);
    }





    List<String> options2 = [];
    if (product?.CategoryID==1 || product?.CategoryID==2) {
      options2 = ComputersOptions;
    } else if (product?.CategoryID==3 || product?.CategoryID==4) {
      options2 = BabyOptions;
    } else if (product?.CategoryID==5 || product?.CategoryID==6) {
      options2 = PersonalOptions;
    }
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white,size: 40),
        title: Image.asset('images/PngItem_12080.png', height: 38),

        centerTitle: true,
        //automaticallyImplyLeading: false,
        backgroundColor: Color(0XFF232F3E),
        actions:  [
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child:Icon(
                  Icons.camera_alt,
                  size: 40,
                  color: Colors.white,
                ),
              )
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: ListView(
          children: [
            Text(
              'Edit Product',
              style: TextStyle(fontSize: 40, fontFamily: 'Ember'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 140,
                  child: GestureDetector(
                    onTap: () => pickImage(),
                    child: image!=null ? image : Icon(Icons.camera_alt, size: 170),
                  ),
                )
              ],
            ),

            SizedBox(height: 30,),


            Text(
              'Category',
              style: TextStyle(
                fontFamily: 'Ember',
                fontSize: 30,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: DropdownButton<int>(
                        hint: Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Ember',
                          ),
                        ),
                        value: selectedCategory,
                        items: options2.map((String item) {
                          return DropdownMenuItem<int>(
                            child: Text(item),
                            value: categoryMap[item],
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedCategory = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            Text(
              'Title',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Ember',
              ),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: '${product?.Name}',
                hintStyle: TextStyle(
                  fontFamily: 'Ember',
                  fontSize: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),


            Container(
              height: 10,
            ),
            Text(
              'Price',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Ember',
              ),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                hintText: '${product?.Price}',
                hintStyle: TextStyle(
                  fontFamily: 'Ember',
                  fontSize: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              height: 10,
            ),
            Text(
              'Quantity',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Ember',
              ),
            ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(
                hintText: '${product?.StockQuantity}',
                hintStyle: TextStyle(
                  fontFamily: 'Ember',
                  fontSize: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              height: 10,
            ),
            Text(

              'Description',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Ember',
              ),
            ),
            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: '${product?.Description}',
                hintStyle: TextStyle(
                  fontFamily: 'Ember',
                  fontSize: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 70,
                    child: ElevatedButton(
                      onPressed: () async {
                        int? quantity;
                        if(quantityController.text.toString()!='' && quantityController.text.toString()!=null){
                          quantity = int.parse(quantityController.text.toString());
                        }else{
                          quantity = product?.StockQuantity;
                        }

                        int? price;
                        if(priceController.text.toString()!='' && priceController.text.toString()!=null){
                          price = int.parse(priceController.text.toString());
                        }else{
                          price = product?.Price;
                        }


                        Product product2 = Product(Name: titleController.text.toString(), Price: price!,
                            StockQuantity: quantity!,
                            StoreID: product!.StoreID, CategoryID: selectedCategory,
                            Description: descriptionController.text.toString());

                        final controller = ProductController();
                        bool result = await controller.updateProduct(product2, product.ProductID);


                        if(check==false){
                          bool result2 = await controller.updateImage(product.ProductID!, newImage);

                          if(result == true && result2 == 2){
                            ref.refresh(getProductsProvider(product?.StoreID));
                            Navigator.pop(context);

                          }

                        }

                        if(result){
                          ref.refresh(getProductsProvider(product?.StoreID));
                          Navigator.pop(context);
                        }
                        else{
                          print("could not update");
                        }


                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Ember',
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0XFFFF9900),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 80,
            ),
          ],
        ),
      ),




    );



  }
}