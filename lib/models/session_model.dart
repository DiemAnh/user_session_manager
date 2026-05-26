class SessionModel {
  final String sessionId;
  final String userId;
  final String deviceId;

  final DateTime loginTime;
  DateTime lastActiveTime;

  Map<String, dynamic> sessionData;

  SessionModel({
    required this.sessionId,
    required this.userId,
    required this.deviceId,
    required this.loginTime,
    required this.lastActiveTime,
    required this.sessionData,
  });

  @override
  String toString() {
    return 'Session(sessionId: $sessionId, userId: $userId, deviceId: $deviceId)';
  }
}