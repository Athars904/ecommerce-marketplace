import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/app_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/bottom_nav.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';

class CustomerOrders extends ConsumerStatefulWidget{
  @override
  ConsumerState<CustomerOrders> createState() => CustomerOrdersState();
}

class CustomerOrdersState extends ConsumerState<CustomerOrders>{

  @override
  Widget build(BuildContext context){

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

    var customerOrders = ref.watch(getCustomerOrdersProvider(customerId));
    return Scaffold(
      appBar: CustomAppBar(),

      body: ListView(
        children: [
          Padding(padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Track Your Orders',
              style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'Ember'
              ),
            )],
          )
            ,),

          customerOrders.when(data: (orders){
            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: orders?.length,
                itemBuilder: (context, index)
                {
                  final order = orders?[index];

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

                              title: Text(
                                'Order ${order?.OrderID}',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Ember',
                                ),
                              ),
                              subtitle: Text(
                                'Total: ${order?.TotalSum}Pkr',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Ember',
                                ),
                              ),

                              trailing: Text(
                                'Status: ${order?.status}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Ember',
                                ),
                              )

                          )));
                }
            );



          }, error: (error,stackTree){
            return Text('Error occured while fetching orders');
          }, loading: (){
            return CircularProgressIndicator();
          })

        ],
      ),

      bottomNavigationBar: BottomNav(),

    );
  }
}