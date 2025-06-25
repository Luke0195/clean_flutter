import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tdd/ui/pages/login/login_page.dart';
import 'package:flutter_tdd/ui/pages/login/login_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_page_test.mocks.dart';

@GenerateMocks([LoginPresenter])
void main() {
  late MockLoginPresenter mockLoginPresenter;
  late StreamController<String?> emailErrorController;
  late StreamController<String?> passwordErrorController;
  late StreamController<bool> isFormValidController;
  late StreamController<bool> isLoadingController;
  late StreamController<String?> mainErrorController;

  void initStreams() {
    mockLoginPresenter = MockLoginPresenter();
    emailErrorController = StreamController<String?>();
    passwordErrorController = StreamController<String?>();
    isFormValidController = StreamController<bool>();
    isLoadingController = StreamController<bool>();
    mainErrorController = StreamController<String?>();
  }

  void mockStreams() {
    when(
      mockLoginPresenter.emailErrorStream,
    ).thenAnswer((_) => emailErrorController.stream);
    when(
      mockLoginPresenter.passwordErrorStream,
    ).thenAnswer((_) => passwordErrorController.stream);
    when(
      mockLoginPresenter.isFormValidStream,
    ).thenAnswer((_) => isFormValidController.stream);
    when(
      mockLoginPresenter.isLoadingStream,
    ).thenAnswer((_) => isLoadingController.stream);
    when(
      mockLoginPresenter.mainErrorStream,
    ).thenAnswer((_) => mainErrorController.stream);
  }

  closeStreams() {
    emailErrorController.close();
    passwordErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
    mainErrorController.close();
  }

  setUp(() {
    initStreams();
    mockStreams();
  });

  tearDown(() {
    closeStreams();
  });

  group('Login page', () {
    Future<void> loadPage(WidgetTester tester) async {
      var loginPage = LoginPage(loginPresenter: mockLoginPresenter);
      await tester.pumpWidget(MaterialApp(home: loginPage));
    }

    Finder getKey(String keyName) {
      return find.byKey(Key(keyName));
    }

    testWidgets('Should load correct initial state', (
      WidgetTester tester,
    ) async {
      await loadPage(tester);
      final inputEmail = getKey('emailInput');
      final inputPassword = getKey('passwordInput');
      final buttonFinder = getKey('button_key');
      final TextButton button = tester.widget(buttonFinder);
      expect(
        inputEmail,
        findsOneWidget,
        reason: 'verify is input e-mail exists',
      );
      expect(
        inputPassword,
        findsOneWidget,
        reason: 'verify is input password exists',
      );
      expect(buttonFinder, findsOneWidget);
      expect(button.onPressed, isNull);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('Should call validate with correct value', (
      WidgetTester tester,
    ) async {
      await loadPage(tester);
      final email = faker.internet.email();
      final inputEmail = getKey('emailInput');
      await tester.enterText(inputEmail, email);

      final password = faker.internet.password();
      final inputPassword = getKey('passwordInput');
      await tester.enterText(inputPassword, password);

      verify(mockLoginPresenter.validateEmail(email)).called(1);
      verify(mockLoginPresenter.validatePassword(password)).called(1);
    });

    testWidgets("Should present no error if a valid email is provided", (
      WidgetTester tester,
    ) async {
      await loadPage(tester);
      emailErrorController.add(null);
      await tester.pump();
      expect(find.text('any_error'), findsNothing);
    });
    testWidgets('Should present error if email is invalid', (
      WidgetTester tester,
    ) async {
      await loadPage(tester);
      emailErrorController.add('any_error');
      await tester.pump();
      expect(find.text('any_error'), findsOneWidget);
    });

    testWidgets("Should present an error if a invalid password provided", (
      WidgetTester tester,
    ) async {
      await loadPage(tester);
      passwordErrorController.add('any_error');
      await tester.pump();
      expect(find.text('any_error'), findsOneWidget);
    });
    testWidgets('Should present error if password is invalid', (
      WidgetTester tester,
    ) async {
      await loadPage(tester);
      passwordErrorController.add("any_error");
      await tester.pump();
      expect(find.text('any_error'), findsOneWidget);
    });

    testWidgets("Should enabled button if form is valid", (
      WidgetTester tester,
    ) async {
      await loadPage(tester);
      isFormValidController.add(true);
      await tester.pump();
      final buttonFinder = getKey('button_key');
      final TextButton button = tester.widget(buttonFinder);
      expect(button.onPressed, isNotNull);
    });

    testWidgets("Should disabled button if form is invalid", (
      WidgetTester tester,
    ) async {
      await loadPage(tester);
      isFormValidController.add(false);
      await tester.pump();
      final buttonFinder = getKey('button_key');
      final TextButton button = tester.widget(buttonFinder);
      expect(button.onPressed, isNull);
    });

    testWidgets('Should call authentication on form submit', (
      WidgetTester tester,
    ) async {
      await loadPage(tester);
      isFormValidController.add(true);
      await tester.pump();
      final buttonFinder = getKey('button_key');
      await tester.tap(buttonFinder);
      await tester.pump();
      verify(mockLoginPresenter.auth()).called(1);
    });

    testWidgets("Should present loading", (WidgetTester tester) async {
      await loadPage(tester);
      isLoadingController.add(true);
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets("Should hide loading", (WidgetTester tester) async {
      await loadPage(tester);
      isLoadingController.add(true);
      await tester.pump();
      isLoadingController.add(false);
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('Should present error message if authentication fails', (
      WidgetTester tester,
    ) async {
      await loadPage(tester);
      mainErrorController.add('main error');
      await tester.pump();
      expect(find.text('main error'), findsOneWidget);
    });

    testWidgets('Should close streams of dispose', (WidgetTester tester) async {
      await loadPage(tester);
      addTearDown(() {
        verify(mockLoginPresenter.dispose()).called(1);
      });
    });
  });
}
