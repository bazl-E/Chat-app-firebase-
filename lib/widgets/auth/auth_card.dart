import 'package:chat_app/widgets/picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthCard extends StatefulWidget {
  AuthCard(this.submitData, this.isLoading);
  final void Function(
    String emailAddres,
    String? userName,
    String password,
    dynamic userimage,
    bool isLogin,
    BuildContext ctx,
  ) submitData;
  final bool isLoading;

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = false;

  String? _emailAddress;
  String? _userName;
  String? _passWord;
  XFile? userImage;

  void setImage(XFile image) {
    userImage = image;
  }

  void tryValidateForm() {
    if (userImage == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('add a profile pic'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    final valid = _formKey.currentState!.validate();
    if (valid) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();
      if (_isLogin) {
        widget.submitData(
          _emailAddress!.trim(),
          _userName ?? 'a'.trim(),
          _passWord!.trim(),
          null,
          _isLogin,
          context,
        );
      }
      widget.submitData(
        _emailAddress!.trim(),
        _userName ?? 'a'.trim(),
        _passWord!.trim(),
        userImage!,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) ImagePickers(setImage),
                  TextFormField(
                    key: ValueKey('EmailAddres'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                    ),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please provide a valid Email adress';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _emailAddress = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('UserName'),
                      decoration: InputDecoration(
                        hintText: 'Username',
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Provide atleast 4 charectors';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('Password'),
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Provide minimum 7 charecters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _passWord = value;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (!widget.isLoading)
                    ElevatedButton(
                      onPressed: tryValidateForm,
                      child: Text(_isLogin ? 'Login' : 'signUp'),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(!_isLogin
                          ? 'I already have an account'
                          : 'Creat new account'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
