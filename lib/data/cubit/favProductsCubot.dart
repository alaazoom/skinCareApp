// // import 'package:ecommere2/logic/gettingData/favAPI.dart';
// // import 'package:ecommere2/logic/models/favModel.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:ecommere2/data/cubit/favCubit.dart';

// // abstract class FavListState {}

// // class FavListInitial extends FavListState {}

// // class FavListLoading extends FavListState {}

// // class FavListLoaded extends FavListState {
// //   final List<FavoriteModel> items;
// //   FavListLoaded(this.items);
// // }

// // class FavListError extends FavListState {
// //   final String message;
// //   FavListError(this.message);
// // }

// // class FavListCubit extends Cubit<FavListState> {
// //   final FavApi api;
// //   final String token;
// //   final FavCubit favCubit; // 👈 مهم

// //   List<FavoriteModel> favorites = [];

// //   FavListCubit(
// //     this.api,
// //     this.token,
// //     this.favCubit,
// //   ) : super(FavListInitial());

// //   Future<void> getFavorites() async {
// //     emit(FavListLoading());

// //     try {
// //       final res = await api.getFavorites(token);

// //       final List data = res['data'];

// //       final list = data
// //           .map((e) => FavoriteModel.fromJson(e))
// //           .toList();

// //       favorites = list;

// //       // 👇 استخراج IDs بشكل صحيح
// //       final ids = list.map((e) => e.id).toList();

// //       // 👇 مزامنة مع FavCubit
// //       favCubit.setFavorites(ids);

// //       emit(FavListLoaded(list));
// //     } catch (e) {
// //       emit(FavListError("Failed to load favorites"));
// //     }
// //   }

// //   Future<void> removeFav(int id) async {
// //     final current = favorites;

// //     favorites = favorites.where((e) => e.id != id).toList();
// //     emit(FavListLoaded(favorites));

// //     final res = await api.removeFav(token, id);

// //     if (res["status"] != true) {
// //       favorites = current;
// //       emit(FavListLoaded(favorites));
// //     } else {
// //       // 👇 مهم: تحديث FavCubit كمان
// //       favCubit.setFavorites(favorites.map((e) => e.id).toList());
// //     }
// //   }
// // }


// import 'package:ecommere2/logic/gettingData/favAPI.dart';
// import 'package:ecommere2/logic/models/favModel.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ecommere2/data/cubit/favCubit.dart';

// abstract class FavListState {}

// class FavListInitial extends FavListState {}

// class FavListLoading extends FavListState {}

// class FavListLoaded extends FavListState {
//   final List<FavoriteModel> items;

//   FavListLoaded(this.items);
// }

// class FavListError extends FavListState {
//   final String message;

//   FavListError(this.message);
// }

// class FavListCubit extends Cubit<FavListState> {
//   final FavApi api;
//   final String token;
//   final FavCubit favCubit;

//   List<FavoriteModel> favorites = [];

//   FavListCubit(
//     this.api,
//     this.token,
//     this.favCubit,
//   ) : super(FavListInitial());

//   Future<void> getFavorites() async {
//     emit(FavListLoading());

//     try {
//       final res = await api.getFavorites(token);

//       final List data = res['data'];

//       favorites =
//           data.map((e) => FavoriteModel.fromJson(e)).toList();

//       favCubit.setFavorites(
//         favorites.map((e) => e.id).toList(),
//       );

//       emit(FavListLoaded(favorites));
//     } catch (e) {
//       emit(FavListError("Failed to load favorites"));
//     }
//   }
// Future<void> toggleFav(int productId) async {

//   final oldFavorites = List<int>.from(favorites);

//   final wasFav = favorites.contains(productId);

//   /// تحديث لحظي
//   if (wasFav) {
//     favorites.remove(productId);
//   } else {
//     favorites.add(productId);
//   }

//   emit(FavUpdated());

//   try {

//     dynamic res;

//     if (wasFav) {
//       res = await api.removeFav(token, productId);
//     } else {
//       res = await api.addFav(token, productId);
//     }

//     if (res["status"] == true) {

//       /// 👇 السناك بار
//       emit(
//         FavSuccess(
//           wasFav
//               ? "Removed from favorites"
//               : "Added to favorites",
//         ),
//       );

//     } else {

//       favorites = oldFavorites;

//       emit(FavUpdated());

//       emit(
//         FavError(
//           res["message"] ?? "Operation failed",
//         ),
//       );
//     }

//   } catch (e) {

//     favorites = oldFavorites;

//     emit(FavUpdated());

//     emit(
//       FavError("Server error"),
//     );
//   }
// }
// }



import 'dart:async';

import 'package:ecommere2/data/cubit/favCubit.dart';
import 'package:ecommere2/data/status/favStatus.dart';
import 'package:ecommere2/logic/gettingData/favAPI.dart';
import 'package:ecommere2/logic/models/favModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FavListState {}

class FavListInitial extends FavListState {}

class FavListLoading extends FavListState {}

class FavListLoaded extends FavListState {
  final List<FavoriteModel> items;

  FavListLoaded(this.items);
}

class FavListError extends FavListState {
  final String message;

  FavListError(this.message);
}

class FavListCubit extends Cubit<FavListState> {
  final FavApi api;
  final String token;
  final FavCubit favCubit;

  List<FavoriteModel> favorites = [];

  StreamSubscription? subscription;

  FavListCubit(
    this.api,
    this.token,
    this.favCubit,
  ) : super(FavListInitial()) {

    /// 👇 يسمع لتغييرات FavCubit
    subscription = favCubit.stream.listen((state) {

      if (
          state is FavUpdated ||
          state is FavSuccess
      ) {

        syncFavorites();
      }
    });
  }

  Future<void> getFavorites() async {

    emit(FavListLoading());

    try {

      final res = await api.getFavorites(token);

      final List data = res['data'];

      favorites = data
          .map((e) => FavoriteModel.fromJson(e))
          .toList();

      favCubit.setFavorites(
        favorites.map((e) => e.id).toList(),
      );

      emit(FavListLoaded(favorites));

    } catch (e) {

      emit(FavListError(
        "Failed to load favorites",
      ));
    }
  }

  Future<void> syncFavorites() async {

    try {

      final res = await api.getFavorites(token);

      final List data = res['data'];

      favorites = data
          .map((e) => FavoriteModel.fromJson(e))
          .toList();

      emit(FavListLoaded(favorites));

    } catch (e) {}
  }

  @override
  Future<void> close() {

    subscription?.cancel();

    return super.close();
  }
}