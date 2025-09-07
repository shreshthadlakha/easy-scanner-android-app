import 'package:flutter/material.dart';


class DocumentDetailScreen extends StatelessWidget {
  const DocumentDetailScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Details'),
      ),
      body: const Center(
        child: Text('Document Detail Screen'),
      ),
    );
  }
}
