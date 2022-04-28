import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String? value) validator;
  final String placeholder;

  const FormTextField({
    Key? key,
    required this.controller,
    required this.validator,
    required this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: placeholder,
      ),
    );
  }
}
