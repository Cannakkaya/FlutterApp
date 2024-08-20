import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:psikolog_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    final Finder addButton = find.byIcon(Icons.add);
    expect(addButton, findsOneWidget);
    await tester.tap(addButton);
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
