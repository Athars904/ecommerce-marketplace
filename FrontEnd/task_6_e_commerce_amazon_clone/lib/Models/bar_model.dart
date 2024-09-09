class BarModel{
  final String Month1;
  final String Month2;
  final String Month3;
  final String Month4;
  final String Month5;
  final String Month6;

  BarModel({
    required this.Month1,
    required this.Month2,
    required this.Month3,
    required this.Month4,
    required this.Month5,
    required this.Month6
});

  factory BarModel.fromJson(Map<String,dynamic> json){
    return BarModel(
        Month1: json['Month1'],
        Month2: json['Month2'],
        Month3: json['Month3'],
        Month4: json['Month4'],
        Month5: json['Month5'],
        Month6: json['Month6']);
  }

  factory BarModel.fromJson2(Map<String,dynamic> json){
    return BarModel(
        Month1: json['Month1'].toString(),
        Month2: json['Month2'].toString(),
        Month3: json['Month3'].toString(),
        Month4: json['Month4'].toString(),
        Month5: json['Month5'].toString(),
        Month6: json['Month6'].toString());
  }


  double getMaxValue() {
    return [double.parse(Month1), double.parse(Month2),double.parse(Month3),double.parse(Month4),double.parse(Month5), double.parse(Month6)].reduce((a, b) => a > b ? a : b);
  }



}