import 'package:flutter/material.dart';
import 'package:flutter_tdd/ui/components/heading_line.dart';
import 'package:flutter_tdd/ui/components/login_header.dart';
import 'package:flutter_tdd/ui/pages/login/login_presenter.dart';
class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;
  const LoginPage(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream.listen((isLoading){
            if(isLoading) {
              showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) { 
                return SimpleDialog(children: [
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10,),
                    Text('Aguarde...',textAlign: TextAlign.center,)
                  ],)
                ],);
              });
            }
          });

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
                          child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              HeadinLine1(text: 'Faça seu Login'),
                              SizedBox(height:  8),
                              Text('Partice das enquetes mais nerds comunidade dev!', style:TextStyle(fontSize: 13), textAlign: TextAlign.center, ),
                              SizedBox(height: 12),
                              Text('🚀 Faça login e vote agora!', style: TextStyle(fontSize: 13),),
                              SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                height: 49,
                                child: StreamBuilder<String?>(
                                  stream: presenter.emailErrorStream,
                                  builder: (context, snapshot) {
                                    return TextFormField(
                                      onChanged: presenter.validateEmail,
                                      key: const Key('emailInput'),
                                      style: TextStyle(fontSize: 13),
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        errorText: snapshot.data,
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
                                    );
                                  }
                                ),
                              ),
                              SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                height: 49,
                                child: StreamBuilder<String?>(
                                  stream: presenter.passwordErrorStream,
                                  builder: (context, snapshot) {
                                    return TextFormField(
                                      onChanged: presenter.validatePassword,
                                      key: const Key('passwordInput'),
                                      style: TextStyle(fontSize: 13),
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        errorText: snapshot.data,
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
                                    );
                                  }
                                ),
                              ),
                              SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                height: 42,
                                child: StreamBuilder<Object>(
                                  stream: presenter.isFormValidStream,
                                  builder: (context, snapshot) {
                                    return TextButton(
                                      key: const Key('button_key'),
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStateProperty.all(
                                          Theme.of(context).primaryColor, // igual ao TextFormField
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
                                      onPressed: snapshot.data  == true  ? () => presenter.auth() : null ,
                                      child: Text(
                                        'Entrar'.toUpperCase(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  }
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
                        ),)
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
