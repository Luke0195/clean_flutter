import 'package:flutter/material.dart';
import 'package:flutter_tdd/ui/pages/login/login_presenter.dart';
import 'package:provider/provider.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginPresenter>(context);
    return StreamBuilder<String?>(
      stream: provider.passwordErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          onChanged: provider.validatePassword,
          key: const Key('passwordInput'),
          style: TextStyle(fontSize: 13),
          obscureText: true,
          decoration: InputDecoration(
            errorText: snapshot.data,
            hintText: 'Informe o seu e-mail',
            hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
            labelText: 'Senha',
            labelStyle: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 14,
            ),
            prefixIcon: Icon(Icons.lock),
            suffixIcon: Icon(Icons.remove_red_eye),
          ),
        );
      },
    );
  }
}
