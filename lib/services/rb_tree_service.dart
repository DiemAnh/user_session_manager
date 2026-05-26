import '../models/rb_node.dart';
import '../models/session_model.dart';

class RBTreeService {
  RBNode? root;

  bool isRed(RBNode? node) {
    return node != null && node.color == NodeColor.red;
  }

  void leftRotate(RBNode x) {
    RBNode? y = x.right;

    x.right = y?.left;

    if (y?.left != null) {
      y!.left!.parent = x;
    }

    y?.parent = x.parent;

    if (x.parent == null) {
      root = y;
    } else if (x == x.parent!.left) {
      x.parent!.left = y;
    } else {
      x.parent!.right = y;
    }

    y?.left = x;
    x.parent = y;
  }

  void rightRotate(RBNode y) {
    RBNode? x = y.left;

    y.left = x?.right;

    if (x?.right != null) {
      x!.right!.parent = y;
    }

    x?.parent = y.parent;

    if (y.parent == null) {
      root = x;
    } else if (y == y.parent!.right) {
      y.parent!.right = x;
    } else {
      y.parent!.left = x;
    }

    x?.right = y;
    y.parent = x;
  }

  void insert(SessionModel session) {
    RBNode node = RBNode(session: session);

    RBNode? y;
    RBNode? x = root;

    while (x != null) {
      y = x;

      if (node.session.sessionId.compareTo(x.session.sessionId) < 0) {
        x = x.left;
      } else {
        x = x.right;
      }
    }

    node.parent = y;

    if (y == null) {
      root = node;
    } else if (node.session.sessionId.compareTo(y.session.sessionId) < 0) {
      y.left = node;
    } else {
      y.right = node;
    }

    node.left = null;
    node.right = null;
    node.color = NodeColor.red;

    insertFix(node);
  }

  void insertFix(RBNode node) {
    while (node.parent != null && isRed(node.parent)) {
      if (node.parent == node.parent!.parent?.left) {
        RBNode? uncle = node.parent!.parent?.right;

        if (isRed(uncle)) {
          node.parent!.color = NodeColor.black;
          uncle!.color = NodeColor.black;
          node.parent!.parent!.color = NodeColor.red;
          node = node.parent!.parent!;
        } else {
          if (node == node.parent!.right) {
            node = node.parent!;
            leftRotate(node);
          }

          node.parent!.color = NodeColor.black;
          node.parent!.parent!.color = NodeColor.red;
          rightRotate(node.parent!.parent!);
        }
      } else {
        RBNode? uncle = node.parent!.parent?.left;

        if (isRed(uncle)) {
          node.parent!.color = NodeColor.black;
          uncle!.color = NodeColor.black;
          node.parent!.parent!.color = NodeColor.red;
          node = node.parent!.parent!;
        } else {
          if (node == node.parent!.left) {
            node = node.parent!;
            rightRotate(node);
          }

          node.parent!.color = NodeColor.black;
          node.parent!.parent!.color = NodeColor.red;
          leftRotate(node.parent!.parent!);
        }
      }
    }

    root?.color = NodeColor.black;
  }

  RBNode? search(String sessionId) {
    RBNode? current = root;

    while (current != null) {
      int compare = sessionId.compareTo(current.session.sessionId);

      if (compare == 0) {
        return current;
      }

      if (compare < 0) {
        current = current.left;
      } else {
        current = current.right;
      }
    }

    return null;
  }

  void inorder(RBNode? node, List<SessionModel> result) {
    if (node == null) return;

    inorder(node.left, result);
    result.add(node.session);
    inorder(node.right, result);
  }

  List<SessionModel> getAllSessions() {
    List<SessionModel> result = [];
    inorder(root, result);
    return result;
  }

  void remove(String sessionId) {
    List<SessionModel> sessions = getAllSessions();

    sessions.removeWhere((e) => e.sessionId == sessionId);

    root = null;

    for (var s in sessions) {
      insert(s);
    }
  }
}