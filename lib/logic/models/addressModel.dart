class AddressModel {
  final int id;
  final String title;
  final String addressType;
  final String street;
  final String city;
  final String mobile;
  final String buildingNumber;

  AddressModel({
    required this.id,
    required this.title,
    required this.addressType,
    required this.street,
    required this.city,
    required this.mobile,
    required this.buildingNumber,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      addressType: json["address_type"] ?? "",
      street: json["street"] ?? "",
      city: json["city"] ?? "",
      mobile: json["mobile"] ?? "",
      buildingNumber: json["building_number"] ?? "",
    );
  }
}