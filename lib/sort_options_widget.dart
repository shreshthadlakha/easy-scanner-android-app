import 'package:flutter/material.dart';


class SortOptionsWidget extends StatelessWidget {
  const SortOptionsWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: const Text('Sort by'),
      items: <String>['Date', 'Name', 'Size', 'Page Count']
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (_) {
        // TODO: Implement sort
      },
    );
  }
}
