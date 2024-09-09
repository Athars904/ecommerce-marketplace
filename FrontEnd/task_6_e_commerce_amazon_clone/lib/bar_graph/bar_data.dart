import 'package:flutter/material.dart';
import 'individual_bar.dart';

class BarData {

  double first,second,third,forth,fifth,sixth;

  BarData({required this.first,
    required this.second,
    required this.third,
    required this.forth,
    required this.fifth,
    required this.sixth});

  List<IndividualBar> barData = [];

  void initializeData(){

    barData = [
      IndividualBar(x: 1, y: first),
      IndividualBar(x: 2, y: second),
      IndividualBar(x: 3, y: third),
      IndividualBar(x: 4, y: forth),
      IndividualBar(x: 5, y: fifth),
      IndividualBar(x: 6, y: sixth),




    ];


  }





}