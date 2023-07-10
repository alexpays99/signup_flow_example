import 'package:freezed_annotation/freezed_annotation.dart';

part 'count.freezed.dart';
part 'count.g.dart';

@freezed
class Count with _$Count {
  factory Count({
    int? followers,
    int? following,
    int? posts,
  }) = _Count;

  factory Count.fromJson(Map<String, dynamic> json) => _$CountFromJson(json);
}
