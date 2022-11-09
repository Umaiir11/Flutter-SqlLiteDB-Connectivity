class ModSaleOrderItems {
  //String Items = "";
  final String name;
  final String adddress ;
  final String city ;
  final String email;

  ModSaleOrderItems({
    //required this.Items,
    required this.name,
    required this.adddress,
    required this.city,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'adddress': adddress, 'city': city, 'email': email};
  }
}
