class UserModel {
  final int id;
  final String name;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String phone;
  final String? gender;
  final String image;

  UserModel({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.phone,
    required this.gender,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      username: json['username'],
      phone: json['phone'],
      gender: json['gender'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "username": username,
      "phone": phone,
      "gender": gender,
      "image": image,
    };
  }
}