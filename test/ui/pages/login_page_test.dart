import 'package:flutter/material.dart';
import 'package:flutter_tdd/ui/pages/login_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group('Login page', (){
      testWidgets('Should load correct initial state', (WidgetTester tester) async {
        final loginPage = LoginPage();
        await tester.pumpWidget(MaterialApp(home: loginPage));
        final inputEmail = find.byKey(const Key('emailInput'));
        final inputPassword = find.byKey(const Key('passwordInput'));
        final buttonFinder = find.byKey(const Key('button_key'));
        final TextButton button = tester.widget(buttonFinder);
        expect(inputEmail, findsOneWidget, reason: 'verify is input e-mail exists ');
        expect(inputPassword, findsOneWidget, reason: 'verify is input password exists ');     
        expect(buttonFinder, findsOneWidget);
        expect(button.onPressed, isNull);
      });

  });

}