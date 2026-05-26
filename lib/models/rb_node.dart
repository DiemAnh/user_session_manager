import 'session_model.dart';

enum NodeColor { red, black }

class RBNode {
  SessionModel session;
  NodeColor color;

  RBNode? left;
  RBNode? right;
  RBNode? parent;

  RBNode({
    required this.session,
    this.color = NodeColor.red,
  });
}