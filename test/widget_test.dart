import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:baitul_hikma/app/app.dart';
import 'package:baitul_hikma/app/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await setupDi();
  });

  tearDown(() async {
    await di.reset();
  });

  testWidgets(
    'App smoke test — BaitulHikmaApp builds with dark theme by default and redirects to Login after 3s',
    (WidgetTester tester) async {
      await tester.pumpWidget(const BaitulHikmaApp());
      await tester.pump();
      expect(find.byType(MaterialApp), findsOneWidget);

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.themeMode, equals(ThemeMode.dark));

      // Fast-forward 3 seconds for splash timer
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Verify redirected to LoginScreen
      expect(find.text('Sign In to Your Sanctuary'), findsOneWidget);
    },
  );
}
