
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:ecommere2/data/status/favStatus.dart';
// // import 'package:ecommere2/logic/gettingData/favAPI.dart';

// // class FavCubit extends Cubit<FavState> {
// //   final FavApi api;
// //   final String token;

// //   FavCubit(this.api, this.token) : super(FavInitial());

// //   List<int> favorites = [];

// //   bool isFav(int id) => favorites.contains(id);

// //   void setFavorites(List<int> favIds) {
// //     favorites = favIds;
// //     emit(FavUpdated()); // 🔥 هذا اللي يخلي كل الصفحات تتحدث
// //   }

// //   Future<void> toggleFav(int productId) async {
// //     emit(FavLoading());

// //     try {
// //       final isFavNow = favorites.contains(productId);

// //       if (isFavNow) {
// //         final res = await api.removeFav(token, productId);

// //         if (res["status"] == true) {
// //           favorites.remove(productId);
// //           emit(FavSuccess("Removed successfully"));
// //         } else {
// //           emit(FavError(res["message"] ?? "Failed to remove"));
// //         }

// //         return;
// //       }

// //       final res = await api.addFav(token, productId);

// //       if (res["status"] == true) {
// //         favorites.add(productId);
// //         emit(FavSuccess("Added successfully"));
// //         return;
// //       }

// //       if (res["message"] == "Already in your Favorite List") {
// //         final removeRes = await api.removeFav(token, productId);

// //         if (removeRes["status"] == true) {
// //           favorites.remove(productId);
// //           emit(FavSuccess("Was already added, now removed"));
// //         } else {
// //           emit(FavError(removeRes["message"] ?? "Auto remove failed"));
// //         }

// //         return;
// //       }

// //       emit(FavError(res["message"] ?? "Operation failed"));
// //     } catch (e) {
// //       emit(FavError("Server error"));
// //     }
// //   }
// // }



// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ecommere2/data/status/favStatus.dart';
// import 'package:ecommere2/logic/gettingData/favAPI.dart';

// class FavCubit extends Cubit<FavState> {
//   final FavApi api;
//   final String token;

//   FavCubit(this.api, this.token) : super(FavInitial());

//   List<int> favorites = [];

//   bool isFav(int id) => favorites.contains(id);

//   void setFavorites(List<int> ids) {
//     favorites = ids;
//     emit(FavUpdated());
//   }

//   Future<void> toggleFav(int productId) async {
//     final oldFavorites = List<int>.from(favorites);

//     /// تحديث لحظي UI
//     if (favorites.contains(productId)) {
//       favorites.remove(productId);
//     } else {
//       favorites.add(productId);
//     }

//     emit(FavUpdated());

//     try {
//       final isFavNow = oldFavorites.contains(productId);

//       dynamic res;

//       if (isFavNow) {
//         res = await api.removeFav(token, productId);
//       } else {
//         res = await api.addFav(token, productId);
//       }

//       if (res["status"] != true) {
//         favorites = oldFavorites;
//         emit(FavUpdated());
//         emit(FavError(res["message"] ?? "Operation failed"));
//       }
//     } catch (e) {
//       favorites = oldFavorites;
//       emit(FavUpdated());
//       emit(FavError("Server error"));
//     }
//   }
// }


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommere2/data/status/favStatus.dart';
import 'package:ecommere2/logic/gettingData/favAPI.dart';

class FavCubit extends Cubit<FavState> {

  final FavApi api;
  final String token;

  FavCubit(
    this.api,
    this.token,
  ) : super(FavInitial());

  /// IDs
  List<int> favorites = [];

  bool isFav(int id) {

    return favorites.contains(id);
  }

  /// أول تحميل
  void setFavorites(List<int> ids) {

    favorites = ids;

    emit(FavUpdated());
  }

  Future<void> toggleFav(int productId) async {

    /// نسخة احتياطية
    final oldFavorites =
        List<int>.from(favorites);

    /// هل كان موجود؟
    final wasFav =
        favorites.contains(productId);

    /// تحديث لحظي UI
    if (wasFav) {

      favorites.remove(productId);

    } else {

      favorites.add(productId);
    }

    /// تحديث كل الواجهات مباشرة
    emit(FavUpdated());

    try {

      dynamic res;

      /// API
      if (wasFav) {

        res = await api.removeFav(
          token,
          productId,
        );

      } else {

        res = await api.addFav(
          token,
          productId,
        );
      }

      /// نجاح
      if (res["status"] == true) {

        emit(
          FavSuccess(
            wasFav
                ? "Removed from favorites"
                : "Added to favorites",
          ),
        );

      } else {

        /// رجوع للخلف إذا فشل
        favorites = oldFavorites;

        emit(FavUpdated());

        emit(
          FavError(
            res["message"] ??
                "Operation failed",
          ),
        );
      }

    } catch (e) {

      /// rollback
      favorites = oldFavorites;

      emit(FavUpdated());

      emit(
        FavError(
          "Server error",
        ),
      );
    }
  }
}