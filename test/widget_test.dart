import 'package:flutter_test/flutter_test.dart';
import 'package:assignment_manager/main.dart';

void main() {
  testWidgets('Assignment Manager loads correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const AssignmentManagerApp(),
    );

    expect(find.text('Hello, Ashwini 👋'), findsOneWidget);
    expect(find.text('Your Progress'), findsOneWidget);
    expect(find.text('Upcoming Assignments'), findsOneWidget);
  });
}