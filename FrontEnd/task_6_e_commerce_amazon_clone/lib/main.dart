import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/options.dart';
import 'package:riverpod/riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';

void main() {


  runApp(ProviderScope(
      child:MyApp()));
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home:Options(),

    );
  }
}
