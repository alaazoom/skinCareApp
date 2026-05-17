import 'package:ecommere2/logic/gettingData/updateProfile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../status/updateProfileStatus.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {

  final UpdateProfileApi api;

  UpdateProfileCubit(this.api)
      : super(UpdateProfileInitial());

  Future<void> update({

    required String token,
    required String firstName,
    required String lastName,
    required String email,
    required String countryCode,
    required String mobile,

  }) async {

    try {

      emit(UpdateProfileLoading());

      final response =
          await api.updateProfile(
        token: token,
        firstName: firstName,
        lastName: lastName,
        email: email,
        countryCode: countryCode,
        mobile: mobile,
      );

      emit(
        UpdateProfileSuccess(
          response["message"],
        ),
      );

    } catch (e) {

      emit(
        UpdateProfileError(
          e.toString(),
        ),
      );
    }
  }
}