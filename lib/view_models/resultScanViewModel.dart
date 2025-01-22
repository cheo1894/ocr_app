import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class ResultScanViewModel extends ChangeNotifier {
  int pageIndex = 0;

  late List navButtons;

  ResultScanViewModel({List<String> scan = const []}) {
    navButtons = [
      {
        "title": 'JPEG',
        "icon": Icons.share_outlined,
        "onPressed": () async {
          List<XFile> xFileList = scan.map((e) {
            return XFile(e);
          }).toList();

          final result = await Share.shareXFiles(
            xFileList,
          );

          if (result.status == ShareResultStatus.success) {
            print('Thank you for sharing the picture!');
          }
        },
      },
      {
        "title": "PDF",
        "icon": Icons.share_outlined,
        "onPressed": () async {
          var file = await createPdf(scan);
          debugPrint('leyendo el PDF ${file}');
          final result = await Share.shareXFiles([XFile(file)]);
          if (result.status == ShareResultStatus.success) {
            print('Thank you for sharing the picture!');
          }
        },
      }
    ];
  }

  Future createPdf(List<String> images) async {
    final pdf = pw.Document();

    for (var path in images) {
      final image = pw.MemoryImage(File(path).readAsBytesSync());
      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw.Center(child: pw.Image(image));
      }));
    }

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/document.pdf");
    await file.writeAsBytes(await pdf.save());
    debugPrint('PDF guardado en: ${file.path}');
    return file.path;
  }

  changePageIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }
}
