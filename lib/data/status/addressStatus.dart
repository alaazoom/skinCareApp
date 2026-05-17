import 'package:ecommere2/logic/models/addressModel.dart';

abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final List<AddressModel> addresses;

  AddressLoaded(this.addresses);
}

class AddressError extends AddressState {
  final String message;

  AddressError(this.message);
}