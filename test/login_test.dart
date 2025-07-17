import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:daily_wellness/screens/login_screen.dart';
import 'package:flutter/services.dart';
import 'package:daily_wellness/core/constants/constant.dart';
import 'package:daily_wellness/routes/app_routes.dart';

class _FakeAssetBundle extends AssetBundle {
  @override
  Future<ByteData> load(String key) async {
    return ByteData(0);
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    return '';
  }

  @override
  Future<T> loadStructuredData<T>(String key, Future<T> Function(String value) parser) async {
    return parser('');
  }

  @override
  void evict(String key) {}
}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Login Form Validation', () {
    testWidgets('shows error when fields are empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DefaultAssetBundle(
            bundle: _FakeAssetBundle(),
            child: const Login(showImage: false),
          ),
          routes: {
            AppRoutes.dashboard: (context) => const Scaffold(body: Text('Dashboard')),
          },
        ),
      );
      // Tap the login button
      final loginButton = find.text(login);
      await tester.tap(loginButton);
      await tester.pump();
      // Should show required errors
      expect(find.text(emailRequired), findsOneWidget);
      expect(find.text(passwordRequired), findsOneWidget);
    });

    testWidgets('shows error for invalid email', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DefaultAssetBundle(
            bundle: _FakeAssetBundle(),
            child: const Login(showImage: false),
          ),
          routes: {
            AppRoutes.dashboard: (context) => const Scaffold(body: Text('Dashboard')),
          },
        ),
      );
      // Enter invalid email and valid password
      await tester.enterText(find.byType(TextFormField).at(0), 'invalidemail');
      await tester.enterText(find.byType(TextFormField).at(1), 'password123');
      await tester.tap(find.text(login));
      await tester.pump();
      // Should show email validation error
      expect(find.text(emailValidation), findsOneWidget);
      expect(find.text(passwordRequired), findsNothing);
    });

    testWidgets('no error for valid input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DefaultAssetBundle(
            bundle: _FakeAssetBundle(),
            child: const Login(showImage: false),
          ),
          routes: {
            AppRoutes.dashboard: (context) => const Scaffold(body: Text('Dashboard')),
          },
        ),
      );
      await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'password123');
      await tester.tap(find.text(login));
      await tester.pumpAndSettle();
      expect(find.text(emailRequired), findsNothing);
      expect(find.text(emailValidation), findsNothing);
      expect(find.text(passwordRequired), findsNothing);
      // Should navigate to dashboard
      expect(find.text('Dashboard'), findsOneWidget);
    });
  });
}
