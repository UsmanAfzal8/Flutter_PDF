import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
    required BuildContext context,
  }) async {
    final Uint8List bytes = await pdf.save();

    final Directory dir = await getApplicationDocumentsDirectory();
    final File file = File('${dir.path}/$name');
    Printer? pri = await Printing.pickPrinter(context: context);
    await Printing.directPrintPdf(
        printer: pri!, onLayout: (PdfPageFormat format) async => bytes);
    // List<Printer> printers = await Printing.listPrinters();

    // print(printers[0]);
    // for (var par in printers) {
    //   if (par.isDefault == true) print('show Printer');
    // }
    //await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => bytes);
    // await Printing.sharePdf(bytes: bytes);
    // await Printing.sharePdf(bytes: await pdf.save(), filename: '${dir.path}/$name');
    await file.writeAsBytes(bytes);

    return file;
  }

  // ignore: always_specify_types
  static Future openFile(File file) async {
    final String url = file.path;

    await OpenFile.open(url);
  }

  // ignore: always_specify_types
  static Future printFile(Document file) async {
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => file.save());
    await Printing.sharePdf(
        bytes: await file.save(), filename: 'my-document.pdf');
  }
}