import 'package:flutter/material.dart';


class DocumentCard extends StatelessWidget {
  const DocumentCard({super.key});


  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Document Thumbnail'),
            Text('Document Name'),
            Text('Creation Date'),
            Text('Page Count'),
            Text('File Size'),
          ],
        ),
      ),
    );
  }
}
