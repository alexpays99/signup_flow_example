import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/features/auth/domain/entity/auth_failure.dart';
import 'package:login/features/auth/domain/usecases/sign_out.dart';

import '../../../../../core/injection_container.dart';

part 'feed_state.dart';
part 'feed_cubit.freezed.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit() : super(const FeedState.initial());

  final _signOut = getIt.get<SignOut>();

  Future<Either<AuthFailure, bool>> signout() async {
    final res = await _signOut.call();
    return res.fold(
      (l) => const Left(AuthFailure.local(message: 'Failure to sign out')),
      (r) => Right(r),
    );
  }
}
