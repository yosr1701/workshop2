// lib/queue_provider.dart
import 'package:flutter/foundation.dart'; // Required for ChangeNotifier
class QueueProvider extends ChangeNotifier {
  final List<String> _clients = [];
  List<String> get clients => _clients;
  void addClient(String name) {
    _clients.add(name);
    notifyListeners(); // Notify listeners of the change
  }
  void removeClient(String name) {
    _clients.remove(name);
    notifyListeners();
  }
  void nextClient() {
    if (_clients.isNotEmpty) {
      _clients.removeAt(0);
      notifyListeners();
    }
  }
}