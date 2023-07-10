// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:login/core/domain/entity/user.dart';
// import 'package:login/core/domain/usecase/usecase.dart';
// import 'package:login/core/injection_container.dart';

// import '../../../../../feed/data/models/current_user_state_mode.dart';
// import '../../../../../feed/data/models/post_list_state_model.dart';
// import '../../../../../feed/domain/entity/post/post_entity.dart';
// import '../../../../domain/usecases/get_all_user_posts.dart';
// import '../../../../domain/usecases/get_current_user_info.dart';

// part 'user_page_state.dart';
// part 'user_page_cubit.freezed.dart';

// class UserPageCubit extends Cubit<UserPageState> {
//   UserPageCubit()
//       : super(UserPageState(
//           postListStateModel: PostListStateModel(
//             value: [],
//             postListState: PostListState.initial,
//           ),
//           currentUserStateModel: CurrentUserStateModel(
//             value: null,
//             currentUserState: CurrentUserState.initial,
//           ),
//         ));

//   final getCurrentUserInfo = getIt.get<GetCurrentUserInfo>();
//   final getAllUserPosts = getIt.get<GetAllUserPosts>();
//   int _page = 0;

//   Future<void> fetchCurrentUserInfo() async {
//     emit(state.copyWith(
//       currentUserStateModel: CurrentUserStateModel(
//         value: null,
//         currentUserState: CurrentUserState.loading,
//       ),
//     ));

//     try {
//       final userInfo = await getCurrentUserInfo.call(NoParams());

//       userInfo.fold(
//         (l) => emit(state.copyWith(
//           currentUserStateModel: CurrentUserStateModel(
//             value: null,
//             currentUserState: CurrentUserState.error,
//             message: l.message,
//           ),
//         )),
//         (r) => emit(
//           state.copyWith(
//             currentUserStateModel: CurrentUserStateModel(
//               value: UserEntity(
//                 id: r.id,
//                 email: r.email,
//                 //  phoneNumber: r.phoneNumber,
//                 fullName: r.fullName,
//                 nickname: r.nickname,
//                 dateOfBirth: r.dateOfBirth,
//                 photo: r.photo,
//                 city: r.city,
//                 bio: r.bio,
//                 createdAt: r.createdAt,
//                 updatedAt: r.updatedAt,
//                 followed: r.followed,
//                 count: r.count,
//               ),
//               currentUserState: CurrentUserState.loaded,
//             ),
//           ),
//         ),
//       );
//     } catch (e) {
//       emit(state.copyWith(
//         currentUserStateModel: CurrentUserStateModel(
//           value: null,
//           currentUserState: CurrentUserState.error,
//           message: e.toString(),
//         ),
//       ));
//     }
//   }

//   Future<List<PostEntity>?> fetchAllUserPosts() async {
//     _page++;

//     emit(state.copyWith(
//       postListStateModel: PostListStateModel(
//         postListState: PostListState.loading,
//       ),
//     ));

//     try {
//       final userPosts = await getAllUserPosts.call(_page.toString());

//       userPosts.fold(
//         (l) => emit(state.copyWith(
//           postListStateModel: PostListStateModel(
//             value: [],
//             postListState: PostListState.error,
//             message: l.message,
//           ),
//         )),
//         (r) {
//           final existingPosts = state.postListStateModel?.value;
//           final newPosts = [...?existingPosts, ...r];

//           emit(state.copyWith(
//             postListStateModel: PostListStateModel(
//               value: newPosts,
//               postListState: PostListState.loaded,
//             ),
//           ));
//         },
//       );
//     } catch (e) {
//       emit(state.copyWith(
//         postListStateModel: PostListStateModel(
//           value: [],
//           postListState: PostListState.error,
//           message: e.toString(),
//         ),
//       ));
//     }
//     return null;
//   }

//   Future<List<PostEntity>?> refreshPosts() async {
//     _page = 1;
//     emit(state.copyWith(
//       postListStateModel: PostListStateModel(
//         postListState: PostListState.loading,
//       ),
//     ));

//     try {
//       final userPosts = await getAllUserPosts.call(_page.toString());

//       userPosts.fold(
//         (l) => emit(state.copyWith(
//           postListStateModel: PostListStateModel(
//             value: [],
//             postListState: PostListState.error,
//             message: l.message,
//           ),
//         )),
//         (r) {
//           emit(state.copyWith(
//             postListStateModel: PostListStateModel(
//               value: r,
//               postListState: PostListState.loaded,
//             ),
//           ));
//         },
//       );
//     } catch (e) {
//       emit(state.copyWith(
//         postListStateModel: PostListStateModel(
//           value: [],
//           postListState: PostListState.error,
//           message: e.toString(),
//         ),
//       ));
//     }
//     return null;
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/core/domain/entity/user.dart';
import 'package:login/core/domain/usecase/usecase.dart';
import 'package:login/core/injection_container.dart';

import '../../../../../feed/data/models/current_user_state_mode.dart';
import '../../../../../feed/data/models/post_list_state_model.dart';
import '../../../../../feed/domain/entity/post/post_entity.dart';
import '../../../../domain/usecases/get_all_user_posts.dart';
import '../../../../domain/usecases/get_current_user_info.dart';

part 'user_page_state.dart';
part 'user_page_cubit.freezed.dart';

class UserPageCubit extends Cubit<UserPageState> {
  UserPageCubit()
      : super(UserPageState(
          postListStateModel: PostListStateModel(
            value: [],
            postListState: PostListState.initial,
          ),
          currentUserStateModel: CurrentUserStateModel(
            value: null,
            currentUserState: CurrentUserState.initial,
          ),
        ));

  final getCurrentUserInfo = getIt.get<GetCurrentUserInfo>();
  final getAllUserPosts = getIt.get<GetAllUserPosts>();
  int _page = 0;

  // Future<String> imageUrlToBase64(String imageUrl) async {
  //   try {
  //     final dio = Dio();
  //     final response = await dio.get<Uint8List>(imageUrl,
  //         options: Options(responseType: ResponseType.bytes));
  //     final bytes = response.data;
  //     if (bytes != null) {
  //       final base64String = base64.encode(bytes);
  //       return base64String;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return '';
  // }

  Future<void> fetchCurrentUserInfo() async {
    emit(
      state.copyWith(
        currentUserStateModel: CurrentUserStateModel(
          value: null,
          currentUserState: CurrentUserState.loading,
        ),
      ),
    );

    try {
      final userInfo = await getCurrentUserInfo.call(NoParams());

      userInfo.fold(
        (l) => emit(
          state.copyWith(
            currentUserStateModel: CurrentUserStateModel(
              value: null,
              currentUserState: CurrentUserState.error,
              message: l.message,
            ),
          ),
        ),
        (r) async {
          emit(
            state.copyWith(
              currentUserStateModel: CurrentUserStateModel(
                value: UserEntity(
                  id: r.id,
                  email: r.email,
                  phoneNumber: r.phoneNumber,
                  fullName: r.fullName,
                  nickname: r.nickname,
                  dateOfBirth: r.dateOfBirth,
                  photo: r.photo,
                  city: r.city,
                  bio: r.bio,
                  createdAt: r.createdAt,
                  updatedAt: r.updatedAt,
                  followed: r.followed,
                  count: r.count,
                ),
                currentUserState: CurrentUserState.loaded,
              ),
            ),
          );
          print("CurrentUser: ${state.currentUserStateModel?.value}");
        },
      );
    } catch (e) {
      emit(state.copyWith(
        currentUserStateModel: CurrentUserStateModel(
          value: null,
          currentUserState: CurrentUserState.error,
          message: e.toString(),
        ),
      ));
    }
  }

  Future<List<PostEntity>?> fetchAllUserPosts() async {
    _page++;

    emit(state.copyWith(
      postListStateModel: PostListStateModel(
        postListState: PostListState.loading,
      ),
    ));

    try {
      final userPosts = await getAllUserPosts.call(_page.toString());

      userPosts.fold(
        (l) => emit(state.copyWith(
          postListStateModel: PostListStateModel(
            value: [],
            postListState: PostListState.error,
            message: l.message,
          ),
        )),
        (r) {
          final existingPosts = state.postListStateModel?.value;
          final newPosts = [...?existingPosts, ...r];

          emit(state.copyWith(
            postListStateModel: PostListStateModel(
              value: newPosts,
              postListState: PostListState.loaded,
            ),
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        postListStateModel: PostListStateModel(
          value: [],
          postListState: PostListState.error,
          message: e.toString(),
        ),
      ));
    }
    return null;
  }

  Future<List<PostEntity>?> refreshPosts() async {
    _page = 1;
    emit(state.copyWith(
      postListStateModel: PostListStateModel(
        postListState: PostListState.loading,
      ),
    ));

    try {
      final userPosts = await getAllUserPosts.call(_page.toString());

      userPosts.fold(
        (l) => emit(state.copyWith(
          postListStateModel: PostListStateModel(
            value: [],
            postListState: PostListState.error,
            message: l.message,
          ),
        )),
        (r) {
          emit(state.copyWith(
            postListStateModel: PostListStateModel(
              value: r,
              postListState: PostListState.loaded,
            ),
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        postListStateModel: PostListStateModel(
          value: [],
          postListState: PostListState.error,
          message: e.toString(),
        ),
      ));
    }
    return null;
  }
}
