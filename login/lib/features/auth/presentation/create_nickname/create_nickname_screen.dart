import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/navigation/app_router.gr.dart';
import '../../../../core/utils/styles/colors.dart';
import '../../../../core/widgets/email_password_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../domain/entity/button_state_model.dart';
import '../../domain/entity/field_verifiable_model.dart';
import '../../domain/entity/sign_up_data_entity.dart';
import 'cubit/create_nickname_cubit.dart';

class CreateNicknameScreen extends StatefulWidget {
  final SignUpDataEntity signUpDataModel;

  const CreateNicknameScreen({
    super.key,
    required this.signUpDataModel,
  });

  @override
  State<CreateNicknameScreen> createState() => _CreateNicknameScreenState();
}

class _CreateNicknameScreenState extends State<CreateNicknameScreen> {
  late CreateNicknameCubit cubit =
      BlocProvider.of<CreateNicknameCubit>(context);

  void onPressed() {
    cubit.nextButtonPressed().then((value) {
      value.fold(
        (l) {
          // todo -  move this login in listener
          final credentials =
              widget.signUpDataModel.copyWith(nickname: cubit.nickname);
          context.router.push(
            AddFullNameScreenRoute(
              signUpDataModel: credentials,
            ),
          );
        },
        (r) => true,
      );
    });
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
                LocaleKeys.createNicknameTitle.tr(),
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
                LocaleKeys.createNicknameSubtitle.tr(),
                style: style.textTheme.bodySmall?.copyWith(
                  fontSize: 13,
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
                  BlocBuilder<CreateNicknameCubit, CreateNicknameState>(
                    builder: (context, state) {
                      final fieldModel = state.nickname;

                      return NicknameField(
                        cubit: cubit,
                        fieldModel: fieldModel,
                        style: style,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child:
                        BlocBuilder<CreateNicknameCubit, CreateNicknameState>(
                      builder: (context, state) {
                        final buttonModel = state.nextNicknameButton;

                        return PrimaryButton(
                          state: buttonModel ?? ButtonState.inactive,
                          text: LocaleKeys.next.tr(),
                          onPress: onPressed,
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NicknameField extends StatelessWidget {
  const NicknameField({
    super.key,
    required this.cubit,
    required this.fieldModel,
    required this.style,
  });

  final CreateNicknameCubit cubit;
  final FieldVerifiableModel? fieldModel;
  final ThemeData style;

  @override
  Widget build(BuildContext context) {
    late Widget suffixIcon;
    late BorderSide? borderSide;
    late Color suffixColor;

    switch (fieldModel?.validationState) {
      case ValidationState.unknown:
        suffixIcon = const Icon(Icons.close, size: 15);
        borderSide = style.inputDecorationTheme.border?.borderSide;
        suffixColor = CustomPalette.black45;
        break;
      case ValidationState.valid:
        suffixIcon = const Center(
          child: Icon(
            Icons.check,
            color: CustomPalette.successGreen,
            size: 15,
          ),
        );
        borderSide = style.inputDecorationTheme.border?.borderSide;
        suffixColor = CustomPalette.successGreen;
        break;
      case ValidationState.invalid:
        suffixIcon = const Center(
          child: Icon(
            Icons.close,
            color: CustomPalette.errorRed,
            size: 15,
          ),
        );
        borderSide = style.inputDecorationTheme.border?.borderSide.copyWith(
          color: CustomPalette.errorRed,
        );
        suffixColor = CustomPalette.errorRed;
        break;
      default:
        Container();
    }
    return EmailPasswordTextFieldS(
      suffixIcon: suffixIcon,
      borderSide: borderSide,
      hintText: LocaleKeys.nickname.tr(),
      helperText: fieldModel?.message,
      suffixColor: suffixColor,
      onChanged: (inputData) {
        cubit.nicknameInput(inputData);
      },
    );
  }
}
