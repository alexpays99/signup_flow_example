import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login/core/utils/styles/colors.dart';
import 'package:login/core/widgets/email_password_text_field.dart';
import 'package:login/navigation/app_router.gr.dart';
import '../../../../core/keys/asset_path.dart';
import '../../../../core/widgets/dialogue.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../domain/entity/button_state_model.dart';
import '../../domain/entity/field_verifiable_model.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc bloc = BlocProvider.of<LoginBloc>(context);

  Icon _getSuffixIcon(FieldVerifiableModel<dynamic>? textField) {
    switch (textField?.validationState) {
      case ValidationState.unknown:
        return const Icon(Icons.close, size: 15);
      case ValidationState.valid:
        return const Icon(Icons.close, size: 15);
      case ValidationState.invalid:
        return const Icon(
          Icons.close,
          color: CustomPalette.errorRed,
          size: 15,
        );
      default:
        return const Icon(Icons.close, size: 15);
    }
  }

  Color _getSuffixColor(FieldVerifiableModel<dynamic>? textField) {
    switch (textField?.validationState) {
      case ValidationState.unknown:
        return CustomPalette.black45;
      case ValidationState.valid:
        return CustomPalette.black45;
      case ValidationState.invalid:
        return CustomPalette.errorRed;
      default:
        return CustomPalette.black45;
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      bloc: context.read<AuthBloc>(),
      listener: (context, state) {
        state.mapOrNull(
          loggedIn: (loggedIn) {
            context.router.replaceAll(const [SocialNetworkBlocProviderRoute()]);
          },
        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.dialogueError != null) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => BaseDialogue(
                    title: state.dialogueError!.title,
                    content: state.dialogueError!.message,
                    mainAction: DialogueAction(
                      name: LocaleKeys.tryAgain.tr(),
                      action: () {
                        context.popRoute();
                      },
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              final phoneOrEmailField = state.loginPhoneOrEmail;
              final passwordField = state.loginPassword;
              final loginButton = state.loginButton;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  SvgPicture.asset(
                    AssetPath.loginBro,
                    // AssetPath.internGram,
                    // width: 230,
                    // height: 48,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 2,
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 42, bottom: 16),
                    child: EmailPasswordTextFieldS(
                      suffixIcon: _getSuffixIcon(phoneOrEmailField),
                      suffixColor: _getSuffixColor(phoneOrEmailField),
                      borderSide: phoneOrEmailField.validationState ==
                              ValidationState.invalid
                          ? style.inputDecorationTheme.border?.borderSide
                              .copyWith(
                              color: CustomPalette.errorRed,
                            )
                          : style.inputDecorationTheme.border?.borderSide,
                      hintText: LocaleKeys.phoneOrEmail.tr(),
                      onChanged: (inputData) {
                        print(inputData);
                        bloc.add(
                          LoginEvent.loginPhoneOrEmailInput(
                              inputData: inputData),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: EmailPasswordTextFieldS(
                      isPassword: true,
                      suffixIcon: _getSuffixIcon(passwordField),
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
                          ? LocaleKeys.errorLoginText.tr()
                          : '',
                      onChanged: (inputData) {
                        bloc.add(
                          LoginEvent.loginPasswordInput(inputData: inputData),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            context.router.push(
                              const PasswordRecoveryPhoneOrEmailScreenRoute(),
                            );
                          },
                          child: Text(
                            LocaleKeys.forgotPassword.tr(),
                            style: style.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: CustomPalette.lightblue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PrimaryButton(
                    state: loginButton ?? ButtonState.inactive,
                    text: LocaleKeys.login.tr(),
                    onPress: () {
                      bloc.add(
                        const LoginEvent.loginButtonPressed(),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 42, bottom: 42),
                    child: Text(
                      LocaleKeys.or.tr(),
                      style: style.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: CustomPalette.black65,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SvgPicture.asset(
                            AssetPath.logoFacebook,
                            width: 16,
                            height: 16,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            bloc.add(
                              const LoginEvent.loginWithFacebookPressed(),
                            );
                          },
                          child: Text(
                            LocaleKeys.loginWithFacebook.tr(),
                            style: style.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: CustomPalette.loginblue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SvgPicture.asset(
                          AssetPath.logoGoogle,
                          width: 16,
                          height: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          bloc.add(
                            const LoginEvent.loginWithGooglePressed(),
                          );
                        },
                        child: Text(
                          LocaleKeys.loginWithGoogle.tr(),
                          style: style.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: CustomPalette.loginblue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(flex: 1),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.notAMember.tr(),
                          style: style.textTheme.displaySmall?.copyWith(
                            color: CustomPalette.black65,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.router.push(
                              const PhoneOrEmailScreenRoute(),
                            );
                          },
                          child: Text(
                            LocaleKeys.createAnAccount.tr(),
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
            },
          ),
        ),
      ),
    );
  }
}
