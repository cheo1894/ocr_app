import 'dart:io';

import 'package:flutter/material.dart';

class ResultImageView extends StatelessWidget {
  final String imagePath;
  final String recognizedText;

  const ResultImageView({super.key, this.imagePath = '', this.recognizedText = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image result'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [Image.file(File(imagePath)), SizedBox(height: 20), Text(recognizedText)],
        ),
      ),
    );
  }
}
