import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/core/utils/styles/colors.dart';
import 'package:login/core/widgets/segment_picker.dart';
import 'package:login/features/auth/domain/entity/sign_up_data_entity.dart';
import 'package:login/features/auth/presentation/widgets/submit_email_widget.dart';
import 'package:login/features/auth/presentation/widgets/submit_phone_widget.dart';
import 'package:login/translations/locale_keys.g.dart';

import 'cubit/phone_or_email_cubit.dart';

class PhoneOrEmailScreen extends StatefulWidget {
  const PhoneOrEmailScreen({super.key});

  @override
  State<PhoneOrEmailScreen> createState() => _PhoneOrEmailScreenState();
}

class _PhoneOrEmailScreenState extends State<PhoneOrEmailScreen> {
  final SignUpDataEntity signUpDataModel = const SignUpDataEntity();
  late final PhoneOrEmailCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<PhoneOrEmailCubit>();
    cubit.toDefaultState();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
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
            const SizedBox(height: 40),
            SegmentPicker(
              tabHeight: 400.0,
              phoneTab: SubmitPhoneWidget(signUpDataModel: signUpDataModel),
              emailTab: SubmitEmailWidget(signUpDataModel: signUpDataModel),
              onTabChanged: (tabIndex) {
                cubit.tabChanged(tabIndex);
              },
            )
          ],
        ),
      ),
    );
  }
}
