class Product {
 final int? ProductID;
 final String Name;
 final int Price;
 final int StockQuantity;
 final int StoreID;
 final int? CategoryID;
 final String Description;
 int? Quantity;
 String? image;

 Product({
   this.ProductID,
   required this.Name,
   required this.Price,
   required this.StockQuantity,
   required this.StoreID,
   required this.CategoryID,
   required this.Description,
   this.Quantity,
   this.image

});

  factory Product.fromJson(Map<String,dynamic> json){
   return Product(
       ProductID:json['ProductID'],
       Name: json['Name'],
       Price: json['Price'],
       StockQuantity: json['StockQuantity'],
       StoreID: json['StoreID'],
       CategoryID: json['CategoryID'],
       Description: json['Description'],
       image: json['Image']
   );}

   Map<String,dynamic> toJson(){
     return {
       'name':Name,
       'price':Price,
       'quantity':StockQuantity,
       'store':StoreID,
       'category':CategoryID,
       'description':Description,

     };
   }

   factory Product.fromJson2(Map<String,dynamic> json){

    return Product(
        Name: json['ProductName'],
        Price: json['ProductPrice'],
        StockQuantity: json['ProductQuantity'],
        StoreID: 0,
        CategoryID: 0,
        Description: '',
        image:json['Image']);
  }



 factory Product.fromJson3(Map<String,dynamic> json){
   return Product(
       ProductID:json['ProductID'],
       Name: json['Name'],
       Price: json['Price'],
       StockQuantity: json['StockQuantity'],
       StoreID: json['StoreID'],
       CategoryID: json['CategoryID'],
       Description: json['Description'],
       Quantity: json['Quantity'],
       image: json['Image']
   );}





}