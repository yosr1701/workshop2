// test/waiting_room_manager_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:waiting_room_app/queue_provider.dart';

void main() {
  test('should add a client to the waiting list', () {
    // ARRANGE
    final manager = QueueProvider();

    // ACT
    manager.addClient('John Doe');

    // ASSERT
    expect(manager.clients.length, 1);
    expect(manager.clients.first, 'John Doe');
  });

  // test/waiting_room_manager_test.dart
// Add this test to the existing file
  test('should remove a client from the waiting list', () {
// ARRANGE
    final manager = QueueProvider();
    manager.addClient('John Doe');
    manager.addClient('Jane Doe');
// ACT
    manager.removeClient('John Doe');
// ASSERT
    expect(manager.clients.length, 1);
    expect(manager.clients.first, 'Jane Doe');
  });

  test('should remove the first client when nextClient() is called', () {
// ARRANGE
    final manager = QueueProvider();
    manager.addClient('Client A');
    manager.addClient('Client B');
// ACT
    manager.nextClient();
// ASSERT
    expect(manager.clients.length, 1);
    expect(manager.clients.first, 'Client B');
  });

}
