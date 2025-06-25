import 'package:flutter/material.dart';
import 'package:flutter_tdd/ui/components/error_snackbar.dart';
import 'package:flutter_tdd/ui/components/heading_line.dart';
import 'package:flutter_tdd/ui/components/login_header.dart';
import 'package:flutter_tdd/ui/components/spinner_dialog.dart';
import 'package:flutter_tdd/ui/pages/login/components/password_input.dart';
import 'package:provider/provider.dart';
import './components/email_input.dart';
import 'package:flutter_tdd/ui/pages/login/login_presenter.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter loginPresenter;

  const LoginPage({super.key, required this.loginPresenter});
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    widget.loginPresenter.isLoadingStream.listen((isLoading) {
      if (!mounted) return;
      if (isLoading) {
        showLoading(context);
      } else {
        hideLoading(context);
      }
    });

    widget.loginPresenter.mainErrorStream.listen((String? errorMessage) {
      if (!mounted) return;

      if (errorMessage != null) {
        showErrorMessage(context, errorMessage);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.loginPresenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
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
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        margin: EdgeInsets.all(8),
                        shadowColor: Colors.grey.shade700,
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Provider(
                            create: (_) => widget.loginPresenter,
                            child: Form(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  HeadinLine1(text: 'Faça seu Login'),
                                  SizedBox(height: 8),
                                  Text(
                                    'Partice das enquetes mais nerds comunidade dev!',
                                    style: TextStyle(fontSize: 13),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    '🚀 Faça login e vote agora!',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 49,
                                    child: EmailInput(),
                                  ),
                                  SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 49,
                                    child: PasswordInput()
                                  ),
                                  SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 42,
                                    child: StreamBuilder<Object>(
                                      stream:
                                          widget
                                              .loginPresenter
                                              .isFormValidStream,
                                      builder: (context, snapshot) {
                                        return TextButton(
                                          key: const Key('button_key'),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                snapshot.data == true
                                                    ? WidgetStateProperty.all(
                                                      Theme.of(
                                                        context,
                                                      ).primaryColor, // igual ao TextFormField
                                                    )
                                                    : WidgetStateProperty.all(
                                                      Colors.grey.shade600,
                                                    ),
                                            side: WidgetStateProperty.all(
                                              BorderSide(
                                                width: 0.2,
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).primaryColorDark,
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
                                          onPressed:
                                              snapshot.data == true
                                                  ? () =>
                                                      widget.loginPresenter
                                                          .auth()
                                                  : null,
                                          child: Text(
                                            'Entrar'.toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  SizedBox(height: 12),
                                  TextButton(
                                    onPressed: null,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
