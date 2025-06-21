import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:flutter_tdd/ui/pages/login/login_page.dart';
import 'package:flutter_tdd/ui/pages/login/login_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_page_test.mocks.dart';


@GenerateMocks([LoginPresenter])
void main(){

  late MockLoginPresenter mockLoginPresenter;

  setUp((){
    mockLoginPresenter = MockLoginPresenter();
  });
  
  group('Login page', (){
      
      Future<void> loadPage(WidgetTester tester)async{ 
        var loginPage = LoginPage(mockLoginPresenter);
        await tester.pumpWidget(MaterialApp(home: loginPage));
      }

      Finder getKey(String keyName){
        return find.byKey(Key(keyName));
      }
  
      testWidgets('Should load correct initial state', (WidgetTester tester) async {
        await  loadPage(tester);
        final inputEmail = getKey('emailInput');
        final inputPassword = getKey('passwordInput');
        final buttonFinder = getKey('button_key');
        final TextButton button = tester.widget(buttonFinder);
        expect(inputEmail, findsOneWidget, reason: 'verify is input e-mail exists ');
        expect(inputPassword, findsOneWidget, reason: 'verify is input password exists ');     
        expect(buttonFinder, findsOneWidget);
        expect(button.onPressed, isNull);
      });

      testWidgets('Should call validate with correct value', (WidgetTester tester) async { 
        await loadPage(tester);
        final email = faker.internet.email();
        final inputEmail = getKey('emailInput');
        await tester.enterText(inputEmail, email);
        verify(mockLoginPresenter.validateEmail(email));
      });


  });

}