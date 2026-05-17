import 'dart:convert';
import 'package:ecommere2/data/status/addressStatus.dart';
import 'package:ecommere2/logic/models/addressModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  List<AddressModel> addresses = [];

  Future<void> getAddresses() async {
    emit(AddressLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final url = Uri.parse(
        "https://tullana.toldpath.com/api/customer/profile/address/list",
      );

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["status"] == true) {
        addresses = List<AddressModel>.from(
          data["data"].map((e) => AddressModel.fromJson(e)),
        );

        emit(AddressLoaded(addresses));
      } else {
        emit(AddressError("Failed to load addresses"));
      }
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }
}