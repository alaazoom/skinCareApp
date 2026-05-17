import 'package:ecommere2/data/status/termsStatus.dart';
import 'package:ecommere2/logic/checkInternet.dart';
import 'package:ecommere2/logic/gettingData/getTerms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TermsCubit extends Cubit<TermsState> {
  final TermsRepository repository;
  final InternetChecker internetChecker;

  TermsCubit({
    required this.repository,
    required this.internetChecker,
  }) : super(TermsInitial());

  Future<void> getTerms() async {
    emit(TermsLoading());

    final hasNet = await internetChecker.hasInternet();

    if (!hasNet) {
      final cache = await repository.getCached();

      if (cache != null) {
        emit(TermsOfflineLoaded(cache));
      } else {
        emit(TermsNoInternet());
      }

      return;
    }

    try {
      final data = await repository.fetchTerms();
      emit(TermsLoaded(data));
    } catch (e) {
      final cache = await repository.getCached();

      if (cache != null) {
        emit(TermsOfflineLoaded(cache));
      } else {
        emit(TermsError(e.toString()));
      }
    }
  }
}