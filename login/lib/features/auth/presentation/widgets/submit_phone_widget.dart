import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/core/widgets/phone_text_field.dart';
import 'package:login/features/auth/presentation/login/bloc/login_bloc.dart';
import '../../../../core/utils/styles/colors.dart';
import '../../../../navigation/app_router.gr.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../domain/entity/sign_up_data_entity.dart';
import '../phone_or_email/cubit/phone_or_email_cubit.dart';
import '../phone_or_email/widgets/next_button.dart';
import '../phone_or_email/widgets/phone_email_input.dart';

class SubmitPhoneWidget extends StatefulWidget {
  final SignUpDataEntity signUpDataModel;

  const SubmitPhoneWidget({
    super.key,
    required this.signUpDataModel,
  });

  @override
  State<SubmitPhoneWidget> createState() => _SubmitPhoneWidgetState();
}

class _SubmitPhoneWidgetState extends State<SubmitPhoneWidget> {
  late PhoneOrEmailCubit cubit = BlocProvider.of<PhoneOrEmailCubit>(context);
  late LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: BlocConsumer<PhoneOrEmailCubit, PhoneOrEmailState>(
            bloc: cubit,
            listenWhen: (prev, current) {
              return current.isValidated;
            },
            listener: (context, state) {
              final credentials = widget.signUpDataModel.copyWith(
                phoneNumber: state.phone.value,
              );
              context.router.push(
                CreatePasswordScreenRoute(
                  signUpDataModel: credentials,
                ),
              );
            },
            builder: (context, state) {
              final fieldModel = state.phone;

              //Be sure to seta type for this widget.
              return PhoneEmailInput<PhoneTextField>(
                cubit: cubit,
                fieldModel: fieldModel,
                style: style,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: BlocConsumer<PhoneOrEmailCubit, PhoneOrEmailState>(
            listener: (context, state) {},
            builder: (context, state) {
              final buttonModel = state.nextPhoneOrEmailButton;

              return NextButton(
                buttonModel: buttonModel,
                action: () {
                  cubit.nextButtonPressed();
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.agreeText.tr(),
                style: style.textTheme.titleSmall
                    ?.copyWith(color: CustomPalette.black45),
              ),
              InkWell(
                onTap: () {
                  context.router.push(const TermsAndConditionsScreenRoute());
                },
                child: Text(
                  LocaleKeys.termsAndConditions.tr(),
                  style: style.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: CustomPalette.black45,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.haveAnAccount.tr(),
                style: style.textTheme.displaySmall,
              ),
              InkWell(
                onTap: () {
                  //set default states on login screen and replace replace navigation stack
                  loginBloc.add(const LoginEvent.resetLoginScreenState());
                  context.router.replace(const LoginScreenRoute());
                },
                child: Text(
                  LocaleKeys.login.tr(),
                  style: style.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: CustomPalette.lightblue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
