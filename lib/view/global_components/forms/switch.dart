import 'package:flutter/material.dart';

class FormSwitch extends StatelessWidget {
  final bool value;
  final String placeholder;
  final void Function(bool value) onChanged;

  const FormSwitch({
    Key? key,
    required this.value,
    required this.placeholder,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      title: Text(placeholder),
      onChanged: onChanged,
    );
  }
}
