import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playem/screen/profile_screen.dart';

void main() {
  testWidgets('ProfileScreen has exactly 3 ElevatedButtons with correct text', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ProfileScreen(),
      ),
    );

    await tester.pumpAndSettle(); // Ждём завершения анимаций/фреймов

    // Проверяем, что ровно 3 ElevatedButton на экране
    final buttons = find.byType(ElevatedButton);
    expect(buttons, findsNWidgets(3));

    // Проверяем текст на кнопках
    expect(find.widgetWithText(ElevatedButton, 'Save Foto'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Redact name'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Exit accaunt'), findsOneWidget);
  });
}
