part of 'gallery_cubit.dart';

@freezed
class GalleryState with _$GalleryState {
  const factory GalleryState({
    List<AssetEntity>? assetsList,
    required int selectedIndex,
  }) = _GalleryState;

  factory GalleryState.initial() => const GalleryState(
        selectedIndex: -1,
      );
}
