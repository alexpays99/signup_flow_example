import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'etnter_birthday_state.dart';

part 'etnter_birthday_cubit.freezed.dart';

class EnterBirthdayCubit extends Cubit<DateTime> {
  /// Duration(days: 5844) - 16 years in days
  static final DateTime _initialDate =
      DateTime.now().subtract(const Duration(days: 5844));

  EnterBirthdayCubit() : super(_initialDate);

  void setBirthday(DateTime birthday) {
    emit(birthday);
  }

  void resetDate() {
    emit(_initialDate);
  }
}
