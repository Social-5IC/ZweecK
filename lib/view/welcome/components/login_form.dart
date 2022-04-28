import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zweeck/core/services/api/state_classes/failure.dart';
import 'package:zweeck/view/global_components/forms/text_field.dart';

class LoginForm extends StatefulWidget {
  final Future<Failure?> Function(
    BuildContext context,
    String mail,
    String password,
  ) onSubmit;

  const LoginForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  // form fields
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();

  // form validators
  String? mailValidator(String? mail) {
    if (mail == null || mail.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  // submit callback
  submit() async {
    if (_formKey.currentState!.validate()) {
      String mail = _mailController.value.text;
      String password = _passwordController.value.text;

      Failure? result = await widget.onSubmit(context, mail, password);

      if (result is Failure) {
        // to improve: submit error management
        _mailController.clear();
        _passwordController.clear();
        log(result.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormTextField(
            controller: _mailController,
            validator: mailValidator,
            placeholder: "Username",
          ),
          FormTextField(
            controller: _passwordController,
            validator: passwordValidator,
            placeholder: "Password",
          ),
          ElevatedButton(
            onPressed: submit,
            child: const Text("Login"),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
