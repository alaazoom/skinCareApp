import 'package:ecommere2/data/status/privacyStatus.dart';
import 'package:ecommere2/logic/checkInternet.dart';
import 'package:ecommere2/logic/gettingData/getPrivacy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivacyCubit extends Cubit<PrivacyState> {
  final PrivacyRepository repository;
  final InternetChecker internetChecker;

  PrivacyCubit({
    required this.repository,
    required this.internetChecker,
  }) : super(PrivacyInitial());

  Future<void> getPrivacy() async {
    emit(PrivacyLoading());

    final hasNet = await internetChecker.hasInternet();

    if (!hasNet) {
      final cache = await repository.getCached();

      if (cache != null) {
        emit(PrivacyOfflineLoaded(cache));
      } else {
        emit(PrivacyNoInternet());
      }
      return;
    }

    try {
      final data = await repository.fetchPrivacy();
      emit(PrivacyLoaded(data));
    } catch (e) {
      final cache = await repository.getCached();

      if (cache != null) {
        emit(PrivacyOfflineLoaded(cache));
      } else {
        emit(PrivacyError(e.toString()));
      }
    }
  }
}