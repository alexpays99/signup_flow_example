import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/core/injection_container.dart';
import 'package:login/features/auth/domain/usecases/login_with_credentials.dart';
import 'package:login/features/auth/domain/usecases/login_with_facebook.dart';
import 'package:login/features/auth/domain/usecases/reset_password.dart';
import 'package:login/features/auth/domain/usecases/validate_user_email.dart';
import 'package:login/features/auth/domain/usecases/validate_user_phone.dart';
import 'package:login/features/auth/presentation/add_full_name/bloc/add_full_name_bloc.dart';
import 'package:login/features/auth/presentation/create_nickname/cubit/create_nickname_cubit.dart';
import 'package:login/features/auth/presentation/create_password/bloc/create_password_bloc.dart';
import 'package:login/features/auth/presentation/enter_city/cubit/enter_city_cubit.dart';
import 'package:login/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:login/features/auth/presentation/phone_or_email/cubit/phone_or_email_cubit.dart';

import '../../../core/screens/profile_photo/cubit/profile_photo_cubit.dart';
import '../domain/usecases/request_confirmation_code.dart';
import '../domain/usecases/send_confirmation_code.dart';
import '../domain/usecases/sign_up.dart';
import 'add_bio/cubit/add_bio_cubit.dart';
import 'enter_birthday/cubit/etnter_birthday_cubit.dart';
import 'confirmation_code_screen/bloc/confirmation_code_bloc.dart';

class AuthBlocProvider extends StatelessWidget implements AutoRouteWrapper {
  const AuthBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(
            loginWithCredentials: getIt.get<LoginWithCredentials>(),
            loginWithFacebook: getIt.get<LoginWithFacebook>(),
          ),
        ),
        BlocProvider<CreatePasswordBloc>(
          create: (BuildContext context) => CreatePasswordBloc(
            resetPassword: getIt.get<ResetPassword>(),
          ),
        ),
        BlocProvider<AddFullNameBloc>(
          create: (BuildContext context) => AddFullNameBloc(),
        ),
        BlocProvider<PhoneOrEmailCubit>(
          create: (BuildContext context) => PhoneOrEmailCubit(
            validateUserEmail: getIt.get<ValidateUserEmail>(),
            validateUserPhone: getIt.get<ValidateUserPhone>(),
          ),
        ),
        BlocProvider<CreateNicknameCubit>(
          create: (BuildContext context) => CreateNicknameCubit(),
        ),
        BlocProvider<EnterBirthdayCubit>(
          create: (BuildContext context) => EnterBirthdayCubit(),
        ),
        BlocProvider<ConfirmationCodeBloc>(
          create: (context) => ConfirmationCodeBloc(
            getIt.get<RequestConfirmationCode>(),
            getIt.get<SendConfirmationCode>(),
            getIt.get<SignUp>(),
          ),
        ),
        BlocProvider<ProfilePhotoCubit>(
          create: (BuildContext context) => ProfilePhotoCubit(),
        ),
        BlocProvider<EnterCityCubit>(
          create: (BuildContext context) => EnterCityCubit(),
        ),
        BlocProvider<AddBioCubit>(
          create: (BuildContext context) => AddBioCubit(),
        ),
      ],
      child: this,
    );
  }
}
