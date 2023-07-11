import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/features/auth/presentation/add_bio/cubit/add_bio_cubit.dart';
import 'package:login/navigation/app_router.gr.dart';

import '../../../../core/utils/styles/colors.dart';
import '../../../../core/widgets/common_user_data.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../domain/entity/button_state_model.dart';
import '../../domain/entity/field_verifiable_model.dart';
import '../../domain/entity/setup_profile_data_entity.dart';

class AddBioScreen extends StatelessWidget {
  final SetupProfileDataEntity setupProfileDataEntity;
  const AddBioScreen({
    super.key,
    required this.setupProfileDataEntity,
  });

  Icon _getSuffixIcon(FieldVerifiableModel<dynamic>? textField) {
    switch (textField?.validationState) {
      case ValidationState.unknown:
        return const Icon(Icons.close, size: 15);
      case ValidationState.valid:
        return const Icon(
          Icons.check,
          color: CustomPalette.successGreen,
          size: 15,
        );
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
        return CustomPalette.successGreen;
      case ValidationState.invalid:
        return CustomPalette.errorRed;
      default:
        return CustomPalette.black45;
    }
  }

  @override
  Widget build(BuildContext context) {
    late AddBioCubit cubit = BlocProvider.of<AddBioCubit>(context);
    final style = Theme.of(context);
    print("SETUPDUSERPROFILEDATAMODEL: $setupProfileDataEntity");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<AddBioCubit, AddBioState>(
          bloc: cubit,
          listener: (context, state) {
            if (state.isValidated) {
              context.router.replace(const UserPageRoute());
            }
          },
          builder: (context, state) {
            final bio = state.bio;
            final nextButton = state.nextButton;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    LocaleKeys.addBioTitle.tr(),
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
                      CommonUserData(
                        suffixIcon: _getSuffixIcon(bio),
                        suffixColor: _getSuffixColor(bio),
                        hintText: LocaleKeys.bio.tr(),
                        errorText: bio?.message,
                        maxLength: 120,
                        maxLines: 7,
                        onChanged: (inputData) {
                          cubit.bioInput(bioInputData: inputData);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: PrimaryButton(
                          state: nextButton ?? ButtonState.inactive,
                          text: LocaleKeys.next.tr(),
                          onPress: () async {
                            final res = setupProfileDataEntity.copyWith(
                                bio: state.bio?.value);
                            await cubit.askPushNotificationsPermission();
                            await cubit.sendFileToBackend(res);
                          },
                        ),
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
}
