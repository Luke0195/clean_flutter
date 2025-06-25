import 'package:flutter/material.dart';
import 'package:flutter_tdd/ui/pages/login/login_presenter.dart';
import 'package:provider/provider.dart';

class EmailInput extends StatelessWidget{
  const EmailInput({super.key});


  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<String?>(
      stream: presenter.emailErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          onChanged: presenter.validateEmail,
          key: const Key('emailInput'),
          style: TextStyle(fontSize: 13),
    
          decoration: InputDecoration(
            errorText: snapshot.data,
            hintText: 'Informe o seu e-mail',
            hintStyle: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
            labelText: 'Email',
            labelStyle: TextStyle(
              color:
                  Theme.of(
                    context,
                  ).primaryColorDark,
              fontSize: 14,
            ),
            prefixIcon: Icon(Icons.email),
          ),
        );
      },
    );
  }
}
