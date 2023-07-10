abstract class TimeoutSettings{
  static const String lastRequestKey = 'lastRequest';
  static const String numberOfRequestsKey = 'numberOfRequests';

  static const int normalTimeout = 60; ///seconds
  static const int exceededTimeout = 6; ///minutes
  static const int maxAttempts = 6;
}