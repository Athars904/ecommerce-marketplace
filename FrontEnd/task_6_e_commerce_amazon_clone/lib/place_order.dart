import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/order_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/app_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/bottom_nav.dart';
import 'package:task_6_e_commerce_amazon_clone/customer_home.dart';
import 'package:task_6_e_commerce_amazon_clone/product_details.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';
import 'package:task_6_e_commerce_amazon_clone/thanks.dart';

import 'Controllers/cart_controller.dart';

class PlaceOrder extends ConsumerStatefulWidget{
  @override
  ConsumerState<PlaceOrder> createState() => PlaceOrderState();
}

class PlaceOrderState extends ConsumerState<PlaceOrder>{

  double subTotal1 = 0;
  double fee = 150;


  @override
  Widget build(BuildContext context) {
    int? customerId = ref.watch(customerDetailsProvider).maybeWhen(
      data: (customer) => customer?.CustomerID,
      orElse: () => null,
    );

    if (customerId == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final cartProvider = ref.watch(getCartItemsProvider(customerId));
    final subTotalProvider = ref.watch(getSubTotal(customerId));
    return Scaffold(
      appBar: CustomAppBar(),

      body:ListView(
          children: [

            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Please Verify Your Order!',
                style: TextStyle(
                  fontFamily: 'Ember',
                  fontSize: 30
                ),)

              ],),


            SizedBox(height: 20,),

            cartProvider.when(
                data: (products) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: products?.length,
                    itemBuilder: (context, index) {
                      final product = products?[index];
                      String? image = product?.image;
                      final imageUrl = 'http://10.0.2.2:3000/uploads/${product?.image}';

                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: ListTile(
                              onTap: () {
                                ref
                                    .read(productProvider.notifier)
                                    .state = product;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetails(),
                                  ),
                                );
                              },
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
                                  fontFamily: 'Ember',
                                ),
                              ),
                              subtitle: Text(
                                '${product?.Price}Pkr/- Quantity : ${product
                                    ?.Quantity}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Ember',
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap: () =>
                                    deleteCartItem(product?.ProductID, customerId),

                                child: Icon(Icons.remove),
                              )


                          ),
                        ),
                      );
                    },
                  );




                }
                , error: (error, stackTree) {
              return Text('Error occured while fetching products');
            }, loading: () {
              return CircularProgressIndicator();
            }),

            SizedBox(height: 20,),

            subTotalProvider.when(data: (subTotal){
              subTotal1 = subTotal;
              if(subTotal1 >= 2000){
                fee = 0;
              }
              return Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Subtotal : $subTotal1',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Ember'
                  ),)
                ],
              );


            }, error: (error,stackTree){
              print(error);
              return Text("Error occured while fetching subtotal");
            }, loading: (){
              return CircularProgressIndicator();
            }),


      Row(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Delivery Fee : $fee',
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'Ember'
            ),)
        ],
      ),

            Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('*Free Delivery over order of 2000Pkr.',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Ember'
                  ),)
              ],
            ),

            SizedBox(height: 20,),

            Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Total : ${subTotal1+fee}',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Ember'
                  ),)
              ],
            ),

            SizedBox(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 70,
                      child: ElevatedButton(
                        onPressed: () async{
                          final controller = OrderController();

                          bool result = await controller.placeOrder(customerId);
                          if(result==true){
                            ref.refresh(getCartItemsProvider(customerId));
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Thanks()));
                          }

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0XFFFF9900),
                        ),
                        child: Text(
                          'Place Order',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Ember',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            )



          ],
        ),



      bottomNavigationBar: BottomNav(),

    );
  }

    void deleteCartItem(int? productID, int? customerId) async{
    final controller = CartController();

    //int? productID = product?.ProductID;

    bool result = await controller.deleteCartItem(productID!);
    if(result==true){
    ref.refresh(getCartItemsProvider(customerId!));
    ref.refresh(getSubTotal(customerId));
    }

    }

}