import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/features/auth/domain/entity/sign_up_data_entity.dart';
import '../../../../core/utils/styles/colors.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../navigation/app_router.gr.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../domain/entity/button_state_model.dart';
import 'cubit/etnter_birthday_cubit.dart';

class EnterBirthdayScreen extends StatefulWidget {
  final SignUpDataEntity signUpDataModel;

  const EnterBirthdayScreen({
    super.key,
    required this.signUpDataModel,
  });

  @override
  State<EnterBirthdayScreen> createState() => _EnterBirthdayScreenState();
}

class _EnterBirthdayScreenState extends State<EnterBirthdayScreen> {
  late EnterBirthdayCubit cubit;
  late ThemeData style;

  @override
  void initState() {
    super.initState();
    cubit = context.read<EnterBirthdayCubit>();
    cubit.resetDate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    style = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<EnterBirthdayCubit, DateTime>(
          bloc: cubit,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Text(
                      LocaleKeys.enterBirthdayTitle.tr(),
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
                      LocaleKeys.enterBirthdaySubtitle.tr(),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: CustomPalette.black,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: DateTimePicker(
                      onDateTimeChanged: (newDate) {
                        cubit.setBirthday(newDate);
                      },
                      minYear: 1930,

                      /// Duration(days: 5844) - 16 years in days
                      maxDate:
                          DateTime.now().subtract(const Duration(days: 5844)),
                      currentDate: state,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 220, left: 24, right: 24),
                    child: Text(
                      LocaleKeys.birthdayInfoText.tr(),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: CustomPalette.black45,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: PrimaryButton(
                      state: ButtonState.active,
                      text: LocaleKeys.next.tr(),
                      onPress: () {
                        final credentials = widget.signUpDataModel.copyWith(
                          dateOfBirth:
                              DateFormat('yyyy-MM-dd', 'en').format(state),
                        );
                        print(credentials.dateOfBirth);
                        context.router.push(
                          ConfirmationCodeScreenRoute(userData: credentials),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
