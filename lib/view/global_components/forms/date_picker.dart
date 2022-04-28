import 'package:flutter/material.dart';

class FormDatePicker extends StatelessWidget {
  final DateTime value;
  final String placeholder;
  final void Function(DateTime picked) onPicked;

  const FormDatePicker({
    Key? key,
    required this.value,
    required this.placeholder,
    required this.onPicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    return ListTile(
      title: Text(placeholder),
      subtitle: Text("${value.day} ${months[value.month - 1]} ${value.year}"),
      trailing: IconButton(
        onPressed: () async {
          final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: value,
              firstDate: DateTime(1940),
              lastDate: DateTime.now(),
              helpText: placeholder);
          if (picked != null) {
            onPicked(picked);
          }
        },
        icon: const Icon(Icons.date_range),
      ),
    );
  }
}
