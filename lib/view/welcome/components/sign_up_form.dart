import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zweeck/core/services/api/state_classes/failure.dart';
import 'package:zweeck/view/global_components/forms/date_picker.dart';
import 'package:zweeck/view/global_components/forms/dropdown_menu.dart';
import 'package:zweeck/view/global_components/forms/switch.dart';
import 'package:zweeck/view/global_components/forms/text_field.dart';

class SignUpForm extends StatefulWidget {
  final Future<Failure?> Function(
    BuildContext context,
    String username,
    String password,
    String mail,
    String name,
    String surname,
    String sex,
    String language,
    String birth,
    bool advertiser,
  ) onSubmit;

  const SignUpForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  // form fields
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _mailController = TextEditingController();
  DateTime _birth = DateTime.parse("2000-01-01");
  String _sex = "M";
  String _language = "EN";
  bool _isAdvertiser = false;

  // form validators
  String? usernameValidator(String? username) {
    if (username == null || username.isEmpty) {
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

  String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  String? surnameValidator(String? surname) {
    if (surname == null || surname.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  String? mailValidator(String? mail) {
    if (mail == null || mail.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  // submit callback
  submit() async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.value.text;
      String password = _passwordController.value.text;
      String name = _nameController.value.text;
      String surname = _surnameController.value.text;
      String mail = _mailController.value.text;

      Failure? result = await widget.onSubmit(
        context,
        username,
        password,
        mail,
        name,
        surname,
        _sex,
        _language,
        _birth.toString(),
        _isAdvertiser,
      );

      if (result is Failure) {
        // to improve: submit error management
        _usernameController.clear();
        _passwordController.clear();
        _nameController.clear();
        _surnameController.clear();
        _mailController.clear();
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
            controller: _usernameController,
            validator: usernameValidator,
            placeholder: "Username",
          ),
          FormTextField(
            controller: _passwordController,
            validator: passwordValidator,
            placeholder: "Password",
          ),
          FormTextField(
            controller: _nameController,
            validator: nameValidator,
            placeholder: "Name",
          ),
          FormTextField(
            controller: _surnameController,
            validator: surnameValidator,
            placeholder: "Surname",
          ),
          FormTextField(
            controller: _mailController,
            validator: mailValidator,
            placeholder: "Mail",
          ),
          FormDatePicker(
            value: _birth,
            placeholder: "Birth",
            onPicked: (picked) {
              if (picked != _birth) {
                setState(() {
                  _birth = picked;
                });
              }
            },
          ),
          FormDropdownMenu<String>(
            value: _sex,
            items: const ["M", "F"],
            onChanged: (newSex) {
              setState(() {
                _sex = newSex;
              });
            },
          ),
          FormDropdownMenu<String>(
            value: _language,
            items: const ["EN"],
            onChanged: (newLanguage) {
              setState(() {
                _language = newLanguage;
              });
            },
          ),
          FormSwitch(
            value: _isAdvertiser,
            placeholder: "Are you an advertiser?",
            onChanged: (value) {
              setState(() {
                _isAdvertiser = value;
              });
            },
          ),
          ElevatedButton(
            onPressed: submit,
            child: const Text("Submit"),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _mailController.dispose();
    super.dispose();
  }
}
