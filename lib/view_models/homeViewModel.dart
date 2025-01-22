import 'package:flutter/material.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_app/view/resultImageView.dart';
import 'package:ocr_app/view/resultScanScreen.dart';
import 'package:ocr_app/view/widgets/myBottomSheet.dart';
import 'package:ocr_app/view/widgets/myButton.dart';
import 'package:permission_handler/permission_handler.dart';

class Homeviewmodel extends ChangeNotifier {
  late DocumentScannerOptions documentOptions;
  late DocumentScanner documentScanner;

  List<String> images = [];
  late List homeOptionList;

  Homeviewmodel(BuildContext context) {
    returnHomeOptionList(context);
  }

  returnHomeOptionList(context) {
    homeOptionList = [
      {
        'icon': Icons.document_scanner_outlined,
        'title': 'Scan a document',
        'action': () {
          debugPrint('Ejecutando');
          openOcr(context);
        },
      },
      {
        'icon': Icons.image_search_outlined,
        'title': 'Text recognition',
        'action': () {
          myBottomSheet(
            context,
            Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                MyButton(
                  title: "Camera",
                  onPressed: () {
                    recognizerFromImage(context, camera: true);
                  },
                ),
                MyButton(
                  title: "Gallery",
                  onPressed: () {
                    recognizerFromImage(context, camera: false);
                  },
                )
              ],
            ),
          );
        }
      },
    ];
    notifyListeners();
  }

  Future<void> openOcr(BuildContext context) async {
    // requestPermissions();
    // if (await Permission.camera.isGranted && await Permission.photos.isGranted) {
    documentOptions = DocumentScannerOptions(
      documentFormat: DocumentFormat.jpeg, // set output document format
      mode: ScannerMode.full, // to control what features are enabled
      pageLimit: 5, // setting a limit to the number of pages scanned
      isGalleryImport: true, // importing from the photo gallery
    );

    documentScanner = DocumentScanner(
      options: documentOptions,
    );
    try {
      DocumentScanningResult result = await documentScanner.scanDocument();
      images = result.images;
      debugPrint('Lista de imagenes ' + images.toString());
      debugPrint('PDF de la imagen >>>>>>>' + result.pdf.toString());
      documentScanner.close();

      var res = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScanView(
              scan: images,
            ),
          ));

      debugPrint('Resultado >>>>>>> $res');
      if (res == true) {
        images = [];
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    // } else {
    //   debugPrint("Permission is not granted");
    //   requestPermissions();
    // }
  }

  Future<void> recognizerFromImage(BuildContext context, {bool camera = true}) async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: camera ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      final inputImage = InputImage.fromFilePath(pickedFile.path);
      final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

      recognizedText.blocks.map((e) => debugPrint(e.text)).toList();

      debugPrint('Texto reconocido: ${recognizedText.text}');
      textRecognizer.close();

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultImageView(
              imagePath: pickedFile.path,
              recognizedText: recognizedText.text,
            ),
          ));
    }
  }

  Future<void> requestPermissions() async {
    debugPrint('buscando');
    await Permission.camera.request().then(
      (value) async {
        await Permission.photos.request();
      },
    );
    debugPrint('PERMISOS ${await Permission.camera.status}, ${await Permission.photos.status}');
  }
}
