import 'package:ecommere2/data/status/userStatus.dart';
import 'package:ecommere2/logic/cache/userCache.dart';
import 'package:ecommere2/logic/gettingData/getUser.dart';
import 'package:ecommere2/logic/models/userModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserCubit extends Cubit<UserState> {
  final UserApi api;
  final UserLocalStorage local;

  UserCubit({
    required this.api,
    required this.local,
  }) : super(UserInitial());
Future<void> fetchUser(String token, {bool silent = false}) async {
  if (!silent) {
    emit(UserLoading());
  }

  try {
    final result = await api.getUser(token);

    await local.saveUser(result);

    emit(UserLoaded(result));

  } catch (e) {

    final cached = await local.getUser();

    if (cached != null) {
      emit(UserLoaded(cached));
    } else {
      emit(UserError("No internet or cached data"));
    }
  }
}
}