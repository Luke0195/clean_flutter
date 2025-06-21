import 'package:flutter/material.dart';
import 'package:flutter_tdd/ui/components/heading_line.dart';
import 'package:flutter_tdd/ui/components/login_header.dart';
import 'package:flutter_tdd/ui/pages/login/login_presenter.dart';
import 'package:getwidget/components/text_field/gf_text_field.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;
  const LoginPage(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginHeader(),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeadinLine1(text: 'Login'),
                  Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 42,
                          child: TextFormField(
                            onChanged: presenter.validateEmail,
                            key: const Key('emailInput'),
                            style: TextStyle(fontSize: 13),
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Informe o seu e-mail',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                              labelText: 'Senha',
                              labelStyle: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: 14,
                              ),
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 42,
                          child: TextFormField(
                            key: const Key('passwordInput'),
                            style: TextStyle(fontSize: 13),
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Informe o seu e-mail',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                              labelText: 'Senha',
                              labelStyle: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: 14,
                              ),
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: Icon(Icons.remove_red_eye),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 42,
                          child: TextButton(
                            key: const Key('button_key'),
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Colors.blue.shade900, // igual ao TextFormField
                              ),
                              side: WidgetStateProperty.all(
                                BorderSide(
                                  width: 0.2,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                              shape: WidgetStateProperty.all<
                                RoundedRectangleBorder
                              >(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                              ),
                            ),
                            onPressed: null,
                            child: Text(
                              'Entrar'.toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        GFTextField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            icon: Icon(Icons.email),
                            filled: true,
                            fillColor: Colors.grey.shade100,

                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1,
                              ),
                            ), // outline, underline, borderless
                          ),
                        ),
                        SizedBox(height: 12),
                        TextButton(
                          onPressed: null,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person),
                              SizedBox(width: 8),
                              Text('Criar Conta'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
