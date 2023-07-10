import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/features/auth/domain/entity/sign_up_data_entity.dart';
import '../../../../navigation/app_router.gr.dart';
import '../../../../core/utils/styles/colors.dart';
import '../../../../core/widgets/email_password_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../domain/entity/button_state_model.dart';
import '../../domain/entity/field_verifiable_model.dart';
import 'bloc/add_full_name_bloc.dart';

class AddFullNameScreen extends StatefulWidget {
  final SignUpDataEntity signUpDataModel;

  const AddFullNameScreen({
    super.key,
    required this.signUpDataModel,
  });

  @override
  State<AddFullNameScreen> createState() => _AddFullNameScreenState();
}

class _AddFullNameScreenState extends State<AddFullNameScreen> {
  late AddFullNameBloc bloc = BlocProvider.of<AddFullNameBloc>(context);

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
    final style = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<AddFullNameBloc, AddFullNameState>(
          builder: (context, state) {
            final name = state.name;
            final nextNameButton = state.nextNameButton;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Text(
                    LocaleKeys.addYourFullNameTitle.tr(),
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
                    LocaleKeys.addYourFullNameSubtitle.tr(),
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
                      EmailPasswordTextFieldS(
                        suffixIcon: _getSuffixIcon(name),
                        suffixColor: _getSuffixColor(name),
                        borderSide:
                            name?.validationState == ValidationState.invalid
                                ? style.inputDecorationTheme.border?.borderSide
                                    .copyWith(
                                    color: CustomPalette.errorRed,
                                  )
                                : style.inputDecorationTheme.border?.borderSide,
                        helperText: name?.message,
                        hintText: LocaleKeys.fullName.tr(),
                        onChanged: (inputData) {
                          bloc.add(
                            AddFullNameEvent.nameInput(
                              nameInputData: inputData,
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: PrimaryButton(
                          state: nextNameButton ?? ButtonState.inactive,
                          text: LocaleKeys.next.tr(),
                          onPress: () {
                            final credentials = widget.signUpDataModel.copyWith(
                              fullName: bloc.name,
                            );
                            context.router.push(
                              EnterBirthdayScreenRoute(
                                signUpDataModel: credentials,
                              ),
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
