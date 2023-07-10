import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/user_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late StreamSubscription<AuthRepositoryState> updateStream;
  final AuthRepository authRepository;
  final UserRepository userRepository;

  AuthBloc({
    required this.authRepository,
    required this.userRepository,
  }) : super(const AuthState.unidentified()) {
    on<AuthEvent>((event, emit) {
      event.map(
        signIn: (signIn) {
          emit(AuthState.loggedIn(signIn.userEntity));
        },
        signOut: (signOut) {
          emit(const AuthState.loggedOut());
        },
      );
    });
    updateStream = authRepository.getStateStream().listen((event) async {
      switch (event) {
        case AuthRepositoryState.signedIn:
          final user = await userRepository.getUser();
          user.fold(
            (l) {
              add(const AuthEvent.signOut());
            },
            (r) {
              add(AuthEvent.signIn(r));
            },
          );
          break;
        case AuthRepositoryState.signedOut:
          add(const AuthEvent.signOut());
          break;
        case AuthRepositoryState.unidentified:
          add(const AuthEvent.signOut());
          break;
      }
    });
  }

  @override
  Future<void> close() {
    updateStream.cancel();
    return super.close();
  }
}
