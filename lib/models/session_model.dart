import 'dart:collection';

final class SessionDataEntry extends LinkedListEntry<SessionDataEntry> {
  String key;
  dynamic value;

  SessionDataEntry({required this.key, this.value});
}

final class SessionModel extends LinkedListEntry<SessionModel> {
  final String sessionId;
  final String userId;
  final String deviceId;

  final DateTime loginTime;
  DateTime lastActiveTime;

  LinkedList<SessionDataEntry> sessionData;

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