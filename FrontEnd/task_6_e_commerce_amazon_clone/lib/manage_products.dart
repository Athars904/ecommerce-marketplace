import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/product_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/product_model.dart';
import 'package:task_6_e_commerce_amazon_clone/edit_product.dart';
import 'package:task_6_e_commerce_amazon_clone/nav_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';

class ManageProducts extends ConsumerStatefulWidget{

  @override
  ConsumerState<ManageProducts> createState() => ManageProductsState();
}

class ManageProductsState extends ConsumerState<ManageProducts>{

  bool need = true;
  var products;

  int? storeID;






  @override
  Widget build(BuildContext context) {

    var seller = ref.watch(sellerDetailsProvider);
     return Scaffold(
          drawer: NavBar(),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white,size: 40),
            title: Image.asset('images/PngItem_12080.png',height: 38),

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

          body: seller.when(data: (seller){

             storeID = seller?.StoreID;

            return ref.watch(getProductsProvider(storeID)).when(
                data: (products){
                  return Column(
                    children: [

                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Manage Your Products',
                              style: TextStyle(
                                fontFamily: 'Ember',
                                fontSize: 30,
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        height: 20,
                      ),

                      Expanded(
                        child: ListView.builder(
                            itemCount: products?.length,

                            itemBuilder: (context,index){
                              final product = products?[index];
                              String? image = product?.image;
                              final imageUrl = 'http://10.0.2.2:3000/uploads/${product?.image}';
                              return Container(

                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.black,
                                              width: 1
                                          )
                                      ),
                                      borderRadius: BorderRadius.circular(10)
                                  ),

                                  child: Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child:ListTile(
                                        leading: image!=null ?
                                        Container(
                                          height: 80,
                                          width: 80,
                                            child: Image.network(imageUrl,)


                                        )
                                         : Container(
                                          height: 80,
                                          width: 80,
                                          child: Text('no image'),
                                        ),
                                        title: Text(
                                          '${product?.Name}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Ember'
                                          ),
                                        ),

                                        subtitle: Text(
                                          'Price ${product?.Price}Pkr Left:${product?.StockQuantity}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Ember'
                                          ),



                                        ),

                                        trailing:Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.edit),

                                            Container(
                                              width: 10,
                                            ),

                                            GestureDetector(

                                              onTap: (){
                                                  deleteProduct(product?.ProductID);
                                              },
                                                child: Icon
                                              (Icons.delete),
                                            )
                                          ],
                                        ),

                                        onTap: (){
                                          ref.read(productProvider.state).state=product;

                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProduct()));
                                        },

                                      )


                                  )



                              );


                            })
                        ,
                      )

                    ],




                  );



                }, error: (error,stackTree){
                  return Text("Error in fetching products");
            }, loading: (){
                  return CircularProgressIndicator();
            });



          }, error:
          (error,stackTree){
            return Text("Error in fetching StoreID");
          }, loading: (){
            return CircularProgressIndicator();
          })





      );
    }

  void deleteProduct(int? ProductID) async{
    final controller = ProductController();
    bool result = await controller.deleteProduct(ProductID!);
    if(result==true){
      print("delete successful");
      ref.refresh(getProductsProvider(storeID));
    }
    else{
      print("unsuccessful delete");
    }
  }


   // some();

    // final controller = ProductController();
    // controller.getProducts(28);






}