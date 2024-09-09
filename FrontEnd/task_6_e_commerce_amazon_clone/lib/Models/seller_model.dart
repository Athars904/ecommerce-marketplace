class Seller {
  final int? ID;
  final String Name ;
  final String Email;
  final String BankAccount ;
  final String Phone;
  final String Password;
  final String StoreName;
  final int? StoreID;

  Seller({
    this.ID,
    required this.Name,
    required this.Email,
    required this.BankAccount,
    required this.Phone,
    required this.Password,
    required this.StoreName,
    this.StoreID


  });

  Map<String,dynamic> toJson()=>{
    'name':Name,
    'email':Email,
    'bankAccount':BankAccount,
    'phone':Phone,
    'pass':Password,
    'storeName':StoreName


  };


  factory Seller.fromJson(Map<String,dynamic> json){
    return Seller(
    ID: json['SellerID'],
    Name:json['Name'],
    Email:json['Email']  ,
    BankAccount:json['BankAccount'],
    Phone:json['Phone'],
    Password:json['Password'],
    StoreID: json['StoreID'],
    StoreName: json['StoreName']
    );

  }


}