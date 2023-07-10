import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/features/auth/presentation/enter_city/cubit/enter_city_cubit.dart';
import 'package:login/navigation/app_router.gr.dart';

import '../../../../core/utils/styles/colors.dart';
import '../../../../core/widgets/common_user_data.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../domain/entity/button_state_model.dart';
import '../../domain/entity/field_verifiable_model.dart';
import '../../domain/entity/setup_profile_data_entity.dart';

class EnterCityScreen extends StatelessWidget {
  final SetupProfileDataEntity setupProfileDataEntity;

  const EnterCityScreen({
    super.key,
    required this.setupProfileDataEntity,
  });

  Icon _getSuffixIcon(FieldVerifiableModel<dynamic>? textField) {
    IconData iconData = Icons.close;
    Color iconColor = Colors.black;
    double iconSize = 15.0;

    switch (textField?.validationState) {
      case ValidationState.unknown:
        break;
      case ValidationState.valid:
        iconData = Icons.check;
        iconColor = CustomPalette.successGreen;
        break;
      case ValidationState.invalid:
        iconData = Icons.close;
        iconColor = CustomPalette.errorRed;
        break;
      default:
        break;
    }

    return Icon(
      iconData,
      color: iconColor,
      size: iconSize,
    );
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
    late EnterCityCubit cubit = BlocProvider.of<EnterCityCubit>(context);
    final style = Theme.of(context);
    print("SETUPDUSERPROFILEDATAMODEL: $setupProfileDataEntity");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<EnterCityCubit, EnterCityState>(
          builder: (context, state) {
            final city = state.city;
            final nextButton = state.nextButton;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Text(
                    LocaleKeys.enterCityTitle.tr(),
                    style: style.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: CustomPalette.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 60, right: 60),
                  child: Text(
                    LocaleKeys.enterCitySubtitle.tr(),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
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
                        suffixIcon: _getSuffixIcon(city),
                        suffixColor: _getSuffixColor(city),
                        hintText: LocaleKeys.yourCity.tr(),
                        errorText: city?.message,
                        onChanged: (inputData) {
                          cubit.cityInput(cityInputData: inputData);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: PrimaryButton(
                          state: nextButton ?? ButtonState.inactive,
                          text: LocaleKeys.next.tr(),
                          onPress: () {
                            context.router.pushAll(
                              [
                                AddBioScreenRoute(
                                  setupProfileDataEntity:
                                      setupProfileDataEntity.copyWith(
                                    city: state.city?.value,
                                  ),
                                ),
                              ],
                            );
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
