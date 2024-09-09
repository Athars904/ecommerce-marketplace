import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';
import 'bar_data.dart';

class MyBarGraph extends ConsumerWidget {


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var seller = ref.watch(sellerDetailsProvider);

    final option = ref.read(optionProvider);

    if (option == 1) {
      return seller.when(
        data: (seller) {
          int? storeID = seller?.StoreID;

          return ref.watch(get6Units(storeID!)).when(
            data: (bar) {
              BarData myData = BarData(
                first: double.parse(bar!.Month1),
                second: double.parse(bar!.Month2),
                third: double.parse(bar!.Month3),
                forth: double.parse(bar!.Month4),
                fifth: double.parse(bar!.Month5),
                sixth: double.parse(bar!.Month6),
              );


              final initialMax = bar.getMaxValue();
              double? max;

              if (initialMax % 5 == 0) {
                max = initialMax + 10;
              }
              else {
                max = initialMax + 11;
              }

              myData.initializeData();

              return BarChart(
                BarChartData(
                  minY: 0,
                  maxY: max,
                  barGroups: myData.barData.map(
                        (data) =>
                        BarChartGroupData(
                          x: data.x,
                          barRods: [BarChartRodData(
                              toY: data.y, color: Color(0xFFFF9900))
                          ],
                        ),
                  ).toList(),
                ),
              );
            },
            error: (error, stackTrace) {
              print('Error fetching units: $error');
              return Text('Error occurred fetching units');
            },
            loading: () => CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          print('Error fetching seller details: $error');
          return Text('Error occurred fetching seller details');
        },
        loading: () => CircularProgressIndicator(),
      );
    }

    else {

      return seller.when(
        data: (seller) {
          int? storeID = seller?.StoreID;

          return ref.watch(get6Amounts(storeID!)).when(
            data: (bar) {
              BarData myData = BarData(
                first: double.parse(bar!.Month1),
                second: double.parse(bar!.Month2),
                third: double.parse(bar!.Month3),
                forth: double.parse(bar!.Month4),
                fifth: double.parse(bar!.Month5),
                sixth: double.parse(bar!.Month6),
              );


              final initialMax = bar.getMaxValue();
              double? maxY;

              if (initialMax % 5000 == 0) {
                maxY = initialMax + 5000;
              }
              else {
                 maxY = (initialMax / 5000).ceil() * 5000; // Round up to nearest 5000
              }






              myData.initializeData();

              return BarChart(
                BarChartData(
                  minY: 0,
                  maxY: maxY,
                  barGroups: myData.barData.map(
                        (data) =>
                        BarChartGroupData(
                          x: data.x,
                          barRods: [BarChartRodData(
                              toY: data.y, color: Color(0xFFFF9900))
                          ],
                        ),
                  ).toList(),
                ),
              );
            },
            error: (error, stackTrace) {
              print('Error fetching units: $error');
              return Text('Error occurred fetching units');
            },
            loading: () => CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          print('Error fetching seller details: $error');
          return Text('Error occurred fetching seller details');
        },
        loading: () => CircularProgressIndicator(),
      );

    }
  }
}