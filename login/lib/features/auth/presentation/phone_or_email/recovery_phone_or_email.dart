import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/core/widgets/outline_gradient_button.dart';
import 'package:login/core/widgets/primary_button.dart';
import 'package:login/features/auth/presentation/phone_or_email/cubit/phone_or_email_cubit.dart';
import 'package:login/features/auth/presentation/phone_or_email/widgets/phone_email_input.dart';

import '../../../../core/utils/styles/colors.dart';
import '../../../../core/widgets/email_password_text_field.dart';
import '../../../../core/widgets/phone_text_field.dart';
import '../../../../core/widgets/segment_picker.dart';
import '../../../../navigation/app_router.gr.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../domain/entity/button_state_model.dart';

class PasswordRecoveryPhoneOrEmailScreen extends StatefulWidget {
  const PasswordRecoveryPhoneOrEmailScreen({super.key});

  @override
  State<PasswordRecoveryPhoneOrEmailScreen> createState() =>
      _PasswordRecoveryPhoneOrEmailScreenState();
}

class _PasswordRecoveryPhoneOrEmailScreenState
    extends State<PasswordRecoveryPhoneOrEmailScreen> {
  late final ThemeData style;
  late final PhoneOrEmailCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<PhoneOrEmailCubit>();
    cubit.toDefaultState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    style = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<PhoneOrEmailCubit, PhoneOrEmailState>(
          bloc: cubit,
          listenWhen: (prev, cur) {
            return cur.isValidated;
          },
          listener: (context, state) {
            context.router.replace(const LoginScreenRoute());
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Text(
                    LocaleKeys.phoneOrEmailTitle.tr(),
                    style: style.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: CustomPalette.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 40.0,
                    left: 50.0,
                    right: 50.0,
                  ),
                  child: Text(
                    LocaleKeys.passwordRecoveryPhoneOrEmail.tr(),
                    style: style.textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                SegmentPicker(
                  tabHeight: 120.0,
                  phoneTab: PhoneEmailInput<PhoneTextField>(
                    cubit: cubit,
                    fieldModel: state.phone,
                    style: style,
                  ),
                  emailTab: PhoneEmailInput<EmailPasswordTextFieldS>(
                    cubit: cubit,
                    fieldModel: state.email,
                    style: style,
                  ),
                  onTabChanged: (index) {
                    cubit.tabChanged(index);
                  },
                ),
                PrimaryButton(
                  state: state.nextPhoneOrEmailButton ?? ButtonState.inactive,
                  text: LocaleKeys.next.tr(),
                  onPress: () {
                    cubit.recoveryNextButtonPressed();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 8),
                  child: Text(
                    LocaleKeys.or.tr(),
                    style: style.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: CustomPalette.black65,
                    ),
                  ),
                ),
                OutlineGradientButton(
                  text: LocaleKeys.passwordRecoveryCreateNewAccount.tr(),
                  onTap: () {
                    context.router.replace(const PhoneOrEmailScreenRoute());
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
