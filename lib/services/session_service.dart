import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/session_model.dart';
import 'rb_tree_service.dart';

class SessionService extends ChangeNotifier {
  final RBTreeService tree = RBTreeService();

  bool singleDeviceMode = true;

  final uuid = Uuid();

  void setSingleDeviceMode(bool value) {
    singleDeviceMode = value;
    notifyListeners();
  }

  void login({
    required String userId,
    required String deviceId,
  }) {
    if (singleDeviceMode) {
      logoutAllByUser(userId);
    }

    final session = SessionModel(
      sessionId: uuid.v4(),
      userId: userId,
      deviceId: deviceId,
      loginTime: DateTime.now(),
      lastActiveTime: DateTime.now(),
      sessionData: LinkedList<SessionDataEntry>(),
    );

    tree.insert(session);

    notifyListeners();
  }

  void updateActivity(String sessionId) {
    final node = tree.search(sessionId);

    if (node != null) {
      node.session.lastActiveTime = DateTime.now();
      notifyListeners();
    }
  }

  void logout(String sessionId) {
    tree.remove(sessionId);
    notifyListeners();
  }

  void logoutAllByUser(String userId) {
    final sessions = tree.getAllSessions();

    for (var s in sessions) {
      if (s.userId == userId) {
        tree.remove(s.sessionId);
      }
    }

    notifyListeners();
  }

  LinkedList<SessionModel> get sessions {
    return tree.getAllSessions();
  }
}