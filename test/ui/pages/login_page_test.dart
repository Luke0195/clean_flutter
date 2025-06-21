import 'package:flutter/material.dart';
import 'package:flutter_tdd/ui/pages/login_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group('Login page', (){

  Future<void> loadPage(WidgetTester tester)async{
    final loginPage = LoginPage();
    await tester.pumpWidget(MaterialApp(home: loginPage));
  }
      testWidgets('Should load correct initial state', (WidgetTester tester) async {
        await  loadPage(tester);
        final inputEmail = find.byKey(const Key('emailInput'));
        final inputPassword = find.byKey(const Key('passwordInput'));
        final buttonFinder = find.byKey(const Key('button_key'));
        final TextButton button = tester.widget(buttonFinder);
        expect(inputEmail, findsOneWidget, reason: 'verify is input e-mail exists ');
        expect(inputPassword, findsOneWidget, reason: 'verify is input password exists ');     
        expect(buttonFinder, findsOneWidget);
        expect(button.onPressed, isNull);
      });

      testWidgets('Should call validate with correct value', (WidgetTester tester) async { 
        await loadPage(tester);
        final inputEmail = find.byKey(const Key('emailInput'));
        await tester.enterText(inputEmail, 'any_test');
        expect(find.text('O campo e-mail é obrigátorio'), findsOneWidget);
      });


  });

}