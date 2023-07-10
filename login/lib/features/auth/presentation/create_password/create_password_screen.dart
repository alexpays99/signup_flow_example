import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/features/auth/domain/entity/sign_up_data_entity.dart';
import 'package:login/navigation/app_router.gr.dart';
import '../../../../core/utils/styles/colors.dart';
import '../../../../core/widgets/email_password_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../domain/entity/field_verifiable_model.dart';
import '../widgets/password_criteria_widget.dart';
import 'bloc/create_password_bloc.dart';
import 'bloc/create_password_event.dart';
import 'bloc/create_password_state.dart';

class CreatePasswordScreen extends StatefulWidget {
  final SignUpDataEntity signUpDataModel;

  const CreatePasswordScreen({
    super.key,
    required this.signUpDataModel,
  });

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  late CreatePasswordBloc bloc = BlocProvider.of<CreatePasswordBloc>(context);

  Color _getSuffixColor(FieldVerifiableModel<dynamic>? textField) {
    switch (textField?.validationState) {
      case ValidationState.unknown:
        return CustomPalette.black45;
      case ValidationState.valid:
        return CustomPalette.successGreen;
      case ValidationState.invalid:
        return CustomPalette.errorRed;
      default:
        return CustomPalette.black45;
    }
  }

  @override
  void initState() {
    super.initState();
    bloc.add(const CreatePasswordEvent.resetState());
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<CreatePasswordBloc, CreatePasswordState>(
          builder: (context, state) {
            final passwordField = state.password;
            // final verifyPassword = state.verifyPassword;
            final confirmPassword = state.confirmPassword;
            final nextButton = state.nextButton;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Text(
                    LocaleKeys.createPassword.tr(),
                    style: style.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: CustomPalette.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      EmailPasswordTextFieldS(
                        isPassword: true,
                        suffixColor: _getSuffixColor(passwordField),
                        borderSide: passwordField.validationState ==
                                ValidationState.invalid
                            ? style.inputDecorationTheme.border?.borderSide
                                .copyWith(
                                color: CustomPalette.errorRed,
                              )
                            : style.inputDecorationTheme.border?.borderSide,
                        hintText: LocaleKeys.password.tr(),
                        helperText: passwordField.validationState ==
                                ValidationState.invalid
                            ? LocaleKeys.errorPasswordText.tr()
                            : '',
                        onChanged: (inputData) {
                          bloc.add(
                            CreatePasswordEvent.passwordInput(
                              passwordInputData: inputData,
                            ),
                          );
                        },
                      ),
                      PasswordCriteriaWidget(
                        hasEightCharacters: state.hasEightCharacters,
                        hasUppercase: state.hasUppercase,
                        hasLowercase: state.hasLowercase,
                        hasDigit: state.hasDigit,
                        hasSpecialCharacter: state.hasSpecialCharacter,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
                        child: EmailPasswordTextFieldS(
                          isPassword: true,
                          suffixColor: _getSuffixColor(confirmPassword),
                          borderSide: confirmPassword.validationState ==
                                  ValidationState.invalid
                              ? style.inputDecorationTheme.border?.borderSide
                                  .copyWith(
                                  color: CustomPalette.errorRed,
                                )
                              : style.inputDecorationTheme.border?.borderSide,
                          hintText: LocaleKeys.confirmPassword.tr(),
                          helperText: confirmPassword.message,
                          onChanged: (inputData) {
                            bloc.add(
                              CreatePasswordEvent.confirmPasswordInput(
                                inputData: inputData,
                              ),
                            );
                          },
                        ),
                      ),
                      PrimaryButton(
                        state: nextButton,
                        text: LocaleKeys.next.tr(),
                        onPress: () {
                          onNextPressed(context, passwordField.value);
                        },
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void onNextPressed(BuildContext context, String password) {
    final credentials = widget.signUpDataModel.copyWith(
      password: password,
    );
    context.router.push(
      CreateNicknameScreenRoute(
        signUpDataModel: credentials,
      ),
    );
  }
}
