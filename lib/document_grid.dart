import 'package:flutter/material.dart';
import 'package:easy_scanner/widgets/document_card.dart';


class DocumentGrid extends StatelessWidget {
  const DocumentGrid({super.key});


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 10, // sample count
      itemBuilder: (context, index) {
        return const DocumentCard();
      },
    );
  }
}
