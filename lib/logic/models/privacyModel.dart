class PrivacyModel {
  final String data;

  PrivacyModel({required this.data});

  factory PrivacyModel.fromJson(Map<String, dynamic> json) {
    return PrivacyModel(
      data: json['data'] ?? '',
    );
  }
}