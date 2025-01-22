import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ocr_app/view/widgets/navIcon.dart';
import 'package:ocr_app/view_models/resultScanViewModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ResultScanView extends StatelessWidget {
  final List<String> scan;
  ResultScanView({super.key, this.scan = const []});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ResultScanViewModel(scan: scan),
      child: Consumer<ResultScanViewModel>(
        builder: (context, value, child) {
          return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                title: Text('Images'),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    icon: Icon(Icons.arrow_back_rounded)),
              ),
              body: Stack(
                children: [
                  PageView.builder(
                    onPageChanged: (index) {
                      value.changePageIndex(index);
                    },
                    itemCount: scan.length,
                    itemBuilder: (context, index) {
                      return Image.file(File(scan[index]));
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: ThemeData.dark().scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          heightFactor: 1,
                          widthFactor: 1,
                          child: Text('${value.pageIndex + 1}/${scan.length}')),
                    ),
                  )
                ],
              ),
              bottomNavigationBar: Container(
                color: ThemeData.dark().scaffoldBackgroundColor,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: value.navButtons.map<Widget>((e) {
                    return NavIcon(
                      onPressed: e['onPressed'],
                      icon: e['icon'],
                      title: e['title'],
                    );
                  }).toList(),
                ),
              ));
        },
      ),
    );
  }
}
