import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/core/domain/entity/user.dart';

import '../../../../auth/domain/repository/user_repository.dart';

class UserCubit extends Cubit<UserEntity?> {
  final UserRepository userRepository;
  late StreamSubscription<UserEntity?> userStreamSubscription;

  UserCubit({
    required this.userRepository,
  }) : super(null) {
    userStreamSubscription = userRepository.userUpdateStream.listen((event) {
      emit(event);
    });
  }

  @override
  Future<void> close() {
    userStreamSubscription.cancel();
    return super.close();
  }
}
