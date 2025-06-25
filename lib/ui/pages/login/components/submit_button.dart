import 'package:flutter/material.dart';
import 'package:flutter_tdd/ui/pages/login/login_presenter.dart';
import 'package:provider/provider.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({ super.key });


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginPresenter>(context);
    return StreamBuilder<Object>(
      stream:provider.isFormValidStream,
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
                      provider.auth()
                  : null,
          child: Text(
            'Entrar'.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
