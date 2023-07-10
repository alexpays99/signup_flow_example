import 'package:login/features/auth/sevices/timeout_service/timeout_service_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeoutService {
  final SharedPreferences sharedPreferences;

  TimeoutService(this.sharedPreferences);

  Future<Duration> getTimeout() async {
    final numberOfRequests =
        sharedPreferences.getInt(TimeoutSettings.numberOfRequestsKey) ?? 0;
    final lastRequestTime =
        sharedPreferences.getInt(TimeoutSettings.lastRequestKey) ?? 0;
    final timeFromLastRequest = Duration(
        milliseconds: DateTime.now().millisecondsSinceEpoch - lastRequestTime);
    if (timeFromLastRequest >
        const Duration(minutes: TimeoutSettings.exceededTimeout)) {
      ///resetting streak after cool down
      await sharedPreferences.setInt(
        TimeoutSettings.numberOfRequestsKey,
        0,
      );
      return Duration.zero;
    } else {
      ///checking on which streak stage we currently are
      if (numberOfRequests >= TimeoutSettings.maxAttempts) {
        return const Duration(minutes: TimeoutSettings.exceededTimeout) -
            timeFromLastRequest;
      } else {
        ///checking if normal duration is expired
        if (timeFromLastRequest >=
            const Duration(seconds: TimeoutSettings.normalTimeout)) {
          return Duration.zero;
        } else {
          return const Duration(seconds: TimeoutSettings.normalTimeout) -
              timeFromLastRequest;
        }
      }
    }
  }

  Future<Duration> countRequest() async {
    ///saving current timer
    await sharedPreferences.setInt(
      TimeoutSettings.lastRequestKey,
      DateTime.now().millisecondsSinceEpoch,
    );

    ///counting current request streak
    var numberOfRequests =
        sharedPreferences.getInt(TimeoutSettings.numberOfRequestsKey) ?? 0;
    numberOfRequests++;

    ///saving streak
    await sharedPreferences.setInt(
      TimeoutSettings.numberOfRequestsKey,
      numberOfRequests,
    );

    ///returning value based on streak
    if (numberOfRequests >= TimeoutSettings.maxAttempts) {
      return const Duration(minutes: TimeoutSettings.exceededTimeout);
    } else {
      return const Duration(seconds: TimeoutSettings.normalTimeout);
    }
  }
}
