enum AvatarValidaionState {
  hasPhoto,
  noPhoto,
  tooLargePhoto,
  incorrectFormat,
  notSuitablePhoto,
}

class AvatarValidaionEntity<DataType> {
  AvatarValidaionState avatarVlidationState;
  String? message;

  AvatarValidaionEntity({
    required this.avatarVlidationState,
    this.message,
  });
}
