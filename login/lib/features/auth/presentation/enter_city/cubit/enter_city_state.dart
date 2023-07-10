part of 'enter_city_cubit.dart';

@freezed
class EnterCityState with _$EnterCityState {
  const factory EnterCityState({
    FieldVerifiableModel? city,
    ButtonState? nextButton,
  }) = _EnterCityState;
}
