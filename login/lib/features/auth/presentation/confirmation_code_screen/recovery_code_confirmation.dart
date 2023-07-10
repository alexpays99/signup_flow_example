import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/features/auth/domain/entity/sign_up_data_entity.dart';
import 'package:login/navigation/app_router.gr.dart';

import '../../../../core/utils/styles/colors.dart';
import '../../../../core/widgets/confirmation_code.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../translations/locale_keys.g.dart';
import 'bloc/confirmation_code_bloc.dart';
import 'bloc/confirmation_code_event.dart';
import 'bloc/confirmation_code_state.dart';

class PasswordRecoveryCodeScreen extends StatefulWidget {
  final SignUpDataEntity signUpDataEntity;

  const PasswordRecoveryCodeScreen({
    super.key,
    required this.signUpDataEntity,
  });

  @override
  State<PasswordRecoveryCodeScreen> createState() =>
      _PasswordRecoveryCodeScreenState();
}

class _PasswordRecoveryCodeScreenState
    extends State<PasswordRecoveryCodeScreen> {
  late final ConfirmationCodeBloc bloc;
  late final TextTheme styles;

  @override
  void initState() {
    super.initState();
    bloc = context.read<ConfirmationCodeBloc>();
    bloc.add(const ConfirmationCodeEvent.clearState());

    ///TODO uncomment after bloc refactoring
    bloc.add(ConfirmationCodeEvent.requestCode(widget.signUpDataEntity));
  }

  @override
  void didChangeDependencies() {
    styles = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfirmationCodeBloc, ConfirmationCodeState>(
      bloc: bloc,
      listenWhen: (context, state) {
        return state.validationCompleted;
      },
      listener: (context, state) {
        if (state.validationCompleted) {
          ///TODO is we need to push here?

          context.router.push(
            PasswordRecoveryPasswordScreenRoute(
                signUpDataEntity: widget.signUpDataEntity),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  LocaleKeys.confirmationCodeTitle.tr(),
                  style: styles.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Text(
                  widget.signUpDataEntity.email != null
                      ? LocaleKeys.confirmationCodeDescriptionEmail.tr()
                      : LocaleKeys.confirmationCodeDescriptionPhone.tr(),
                  style: styles.displaySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ConfirmationCode(
                  borderColor: state.codeValidationError != null
                      ? CustomPalette.errorRed
                      : null,
                  onChanged: (code) {
                    bloc.add(ConfirmationCodeEvent.codeChanged(code));
                  },
                ),
              ),
              Offstage(
                offstage: state.codeValidationError == null,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      state.codeValidationError ?? '',
                      style: styles.bodySmall?.copyWith(
                        color: CustomPalette.errorRed,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: PrimaryButton(
                  onPress: () {
                    bloc.add(
                      ConfirmationCodeEvent.sendCode(widget.signUpDataEntity),
                    );
                  },
                  state: state.buttonState,
                  text: LocaleKeys.confirm.tr(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  bottom: 8.0,
                ),
                child: state.codeResendTimeout == null
                    ? Text(
                        LocaleKeys.confirmationCodeDidNotCome.tr(),
                        style: styles.displaySmall?.copyWith(
                          color: Colors.black,
                        ),
                      )
                    : Text(
                        state.codeResendTimeout ?? '',
                        style: styles.displaySmall?.copyWith(
                          color: CustomPalette.errorRed,
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextButton(
                  onPressed: !state.resendBlocked
                      ? () {
                          bloc.add(
                            ConfirmationCodeEvent.requestCode(
                                widget.signUpDataEntity),
                          );
                        }
                      : null,
                  child: Text(
                    LocaleKeys.resend.tr(),
                  ),
                ),
              ),
              Offstage(
                offstage: state.timeout <= Duration.zero,
                child: Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Text(
                    '${state.timeout.inMinutes}:'
                    '${_formattedSeconds(state.timeout.inSeconds.remainder(60))}',
                    style: styles.displaySmall?.copyWith(
                      color: CustomPalette.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formattedSeconds(int seconds) {
    if (seconds >= 10) {
      return seconds.toString();
    } else {
      return '0$seconds';
    }
  }
}
