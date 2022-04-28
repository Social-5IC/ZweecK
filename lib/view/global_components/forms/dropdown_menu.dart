import 'package:flutter/material.dart';

class FormDropdownMenu<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final void Function(dynamic value) onChanged;

  const FormDropdownMenu({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      onChanged: onChanged,
      value: value,
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text("$item"),
            ),
          )
          .toList(),
      isExpanded: true,
    );
  }
}
