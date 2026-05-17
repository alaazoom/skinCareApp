class TermsModel {
  final String data;

  TermsModel({required this.data});

  factory TermsModel.fromJson(Map<String, dynamic> json) {
    return TermsModel(
      data: json['data'] ?? '',
    );
  }
}