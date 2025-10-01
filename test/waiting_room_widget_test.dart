// test/waiting_room_widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waiting_room_app/main.dart';
void main() {
  testWidgets('should add a new client to the list on button tap', (WidgetTester tester)
  async {
// ARRANGE
    await tester.pumpWidget(const WaitingRoomApp());
// ACT
    await tester.enterText(find.byType(TextField), 'Alice');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Rebuild the widget after state change
// ASSERT
    expect(find.text('Alice'), findsOneWidget);
    expect(find.text('Clients in Queue: 1'), findsOneWidget);
  });

  // test/waiting_room_widget_test.dart
// Add this test to the existing file
  testWidgets('should remove a client from the list when the delete button is tapped',
          (WidgetTester tester) async {
// ARRANGE
        await tester.pumpWidget(const WaitingRoomApp());
        await tester.enterText(find.byType(TextField), 'Bob');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();
// ACT
// Find the delete icon associated with 'Bob' and tap it.
        await tester.tap(find.byIcon(Icons.delete));
        await tester.pump();
            // ASSERT
            expect(find.text('Bob'), findsNothing);
            expect(find.text('Clients in Queue: 0'), findsOneWidget);
          });
}