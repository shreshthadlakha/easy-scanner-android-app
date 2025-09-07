import 'package:flutter/material.dart';


class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Documents'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Filter by date range'),
          Text('Filter by tags'),
          Text('Filter by file size'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // TODO: Apply filter
            Navigator.of(context).pop();
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
