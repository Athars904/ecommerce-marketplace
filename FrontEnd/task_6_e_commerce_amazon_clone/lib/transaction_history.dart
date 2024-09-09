import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/nav_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';

class TransactionHistory extends ConsumerStatefulWidget {

  @override
  ConsumerState<TransactionHistory> createState() => TransactionHistoryState();
}

class TransactionHistoryState extends ConsumerState<TransactionHistory> {

  @override
  Widget build(BuildContext context) {
    var seller = ref.watch(sellerDetailsProvider);

    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white,size: 40),

          title: Image.asset('images/PngItem_12080.png', height: 38),
          leading:

          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.menu, color: Colors.white, size: 40,),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
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

        body: seller.when(
            data: (seller){
              int? StoreID = seller?.StoreID;
                  return   ref.watch(getAllTransactionsProvider(StoreID!)).when(
                  data: (transactions){

                    if(transactions?.length==0){
                      return Column (
                        children: [
                      Padding(
                      padding: EdgeInsets.only(top: 50),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text('Transaction History',
                    style: TextStyle(
                    fontFamily: 'Ember',
                    fontSize: 30,
                    ),
                    )
                    ],
                    ),
                    ),



                    Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text('Total Earned : 0 Pkr.',
                    style: TextStyle(
                    fontFamily: 'Ember',
                    fontSize: 20,
                    ),
                    )
                    ],
                    ),
                    ),


                    Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('No Transactions yet',
                                  style: TextStyle(
                                    fontFamily: 'Ember',
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    }
                    else{
                      return Column(
                          children: [

                            Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Transaction History',
                                    style: TextStyle(
                                      fontFamily: 'Ember',
                                      fontSize: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),



                            Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Total Earned : ${transactions?[0].total} Pkr.',
                                    style: TextStyle(
                                      fontFamily: 'Ember',
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Expanded(
                                child:ListView.builder(
                                    itemCount: transactions?.length,
                                    itemBuilder:(context,index){
                                      final transaction = transactions?[index];
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
                                              child: ListTile(
                                                title: Text(
                                                  '${transaction?.Details}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: 'Ember'
                                                  ),
                                                ),

                                                subtitle: Text(
                                                  'Amount: ${transaction?.Amount}Pkr',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'Ember'
                                                  ),


                                                ),

                                                trailing: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons.date_range),

                                                    Container(
                                                      width: 5,
                                                    ),

                                                    Text('${transaction?.Date}',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: 'Ember'
                                                      ),)
                                                  ],
                                                ),


                                              )


                                          )


                                      );

                                    }

                                )
                            )



                          ]
                      );

                    }


                  }, error: (error,stackTree){
                    return Text('Error occured while fetching transactions');
               }, loading:(){
                 return CircularProgressIndicator();
               }
               );






            },
            error: (error,stackTree){
              return Text("error occured fetching seller");
            },
            loading: (){
              return CircularProgressIndicator();
            })

    );
  }


}