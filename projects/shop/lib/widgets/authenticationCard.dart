import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:shop/providers/authentication.dart';
import 'package:shop/exceptions/authenticationException.dart';

enum AuthMode {
  Signup,
  Login,
}

class AuthenticationCard extends StatefulWidget {
  @override
  _AuthenticationCardState createState() => _AuthenticationCardState();
}

class _AuthenticationCardState extends State<AuthenticationCard> {
  GlobalKey<FormState> _form = GlobalKey();
  bool isLoading = false;
  AuthMode _authenticationMode = AuthMode.Login;
  final _passwordController = TextEditingController();
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Ocorreu um erro:"),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_form.currentState.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    _form.currentState.save();

    Authentication authentication = Provider.of(context, listen: false);

    try {
      if (_authenticationMode == AuthMode.Login) {
        // login
        await authentication.login(
          _authData["email"],
          _authData["password"],
        );
      } else {
        // registrar
        await authentication.signup(
          _authData["email"],
          _authData["password"],
        );
      }
    } on AuthenticationException catch (error) {
      this._showErrorDialog(error.toString());
    } catch (error) {
      this._showErrorDialog("Ocorreu um erro inesperado!");
    }

    setState(() {
      isLoading = false;
    });
  }

  void _switchAuthorizationMode() {
    if (this._authenticationMode == AuthMode.Login) {
      setState(() {
        this._authenticationMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        this._authenticationMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: _authenticationMode == AuthMode.Login ? 310 : 392,
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return "Informe um e-mail válido!";
                  }
                  return null;
                },
                onSaved: (value) => _authData['email'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty || value.length < 5) {
                    return "Informe uma senha váida!";
                  }
                  return null;
                },
                onSaved: (value) => _authData['password'] = value,
              ),
              if (_authenticationMode == AuthMode.Signup)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Confirmar Senha'),
                  obscureText: true,
                  validator: _authenticationMode == AuthMode.Signup
                      ? (value) {
                          if (value != _passwordController.text) {
                            return "Senhas são diferentes!";
                          }
                          return null;
                        }
                      : null,
                ),
              Spacer(),
              isLoading
                  ? CircularProgressIndicator()
                  : RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor:
                          Theme.of(context).primaryTextTheme.button.color,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        _authenticationMode == AuthMode.Login
                            ? 'ENTRAR'
                            : 'REGISTRAR',
                      ),
                      onPressed: _submit,
                    ),
              FlatButton(
                onPressed: _switchAuthorizationMode,
                child: Text(
                  "ALTERNAR PARA ${_authenticationMode == AuthMode.Login ? 'REGISTRAR ' : 'LOGIN'}",
                ),
                textColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
