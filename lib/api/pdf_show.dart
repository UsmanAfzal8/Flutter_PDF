import 'dart:io';
import 'package:dotted_line/dotted_line.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:ramzan_hospital_pdf/api/pdf_api.dart';

class PdfInvoiceApi {
  static Future<File> generate(context) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildPdf(),
      ],
    ));

    return PdfApi.saveDocument(name: 'Ramzan Hospital', pdf: pdf,context: context);
  }

  static Widget buildPdf() {
    return Column(children: [
      SizedBox(
        height: 5 * PdfPageFormat.cm,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildHeader(),
              patientData(),
            ]),
      ),
      Divider(),
      SizedBox(
        height: 16 * PdfPageFormat.cm,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [forTest(), Divider(), forDoctor()]),
      ),
      Divider(),
      SizedBox(
        height: 3 * PdfPageFormat.cm,
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
            Column(children: [
              SizedBox(height: 25),
              Text(
                'Doctor Signature',
              ),
            ]),
          ]),
          RichText(
            text: TextSpan(
              text: 'Contect ',
              style: TextStyle(fontSize: 10),
              children: <TextSpan>[
                TextSpan(
                  text: '+92 345 102 1122',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Developed By ',
              style: TextStyle(fontSize: 10),
              children: <TextSpan>[
                TextSpan(
                  text: 'Dev Markaz',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ],
            ),
          ),
        ]),
      ),
    ]);
  }

  static Widget forDoctor() {
    return SizedBox(
      width: 13 * PdfPageFormat.cm,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 3 * PdfPageFormat.cm,
              child: Text('Presenting Complaints:',
                  style: TextStyle(decoration: TextDecoration.underline)),
            ),
            SizedBox(
              height: 3 * PdfPageFormat.cm,
              child: Text('History:',
                  style: TextStyle(decoration: TextDecoration.underline)),
            ),
            SizedBox(
              height: 3 * PdfPageFormat.cm,
              child: Text('Examination:',
                  style: TextStyle(decoration: TextDecoration.underline)),
            ),
            SizedBox(
              height: 1.5 * PdfPageFormat.cm,
              child: Text('Provisional Dignosis:',
                  style: TextStyle(decoration: TextDecoration.underline)),
            ),
            Text('Treatment:',
                style: TextStyle(decoration: TextDecoration.underline)),
          ]),
    );
  }

  static Widget forTest() {
    return SizedBox(
      width: 7 * PdfPageFormat.cm,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Tests',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 20),
        Column(
            children: List.generate(4, (index) {
          final title = 'titles[index]';

          return buildText(title: title);
        })),
        SizedBox(height: 20),
        Text('Investigation :', style: TextStyle(fontWeight: FontWeight.bold)),
      ]),
    );
  }

  static Widget buildHeader() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ramzan Hospital  ',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('Hospital Consulting Form ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(
              'Prescription slip ',
              style: const TextStyle(
                fontSize: 10,
              ),
            )
          ]),
      Container(
        height: 50,
        width: 50,
        child: BarcodeWidget(
          barcode: Barcode.qrCode(),
          data: 'f',
        ),
      ),
    ]);
  }

  static Widget patientData() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Patient Name  ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Contact: '),
                Text('Address: '),
                Text('Gender: '),
              ]),
              SizedBox(width: 10),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('0313-1010754'),
                Text('Shahkot '),
                Text('Male '),
              ]),
            ]),
            Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Date Time : '),
                Text('Consultant: '),
                Text('Department: '),
              ]),
              SizedBox(width: 10),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('20-july-2022'),
                Text('hassan '),
                Text('Eyes'),
              ]),
            ]),
          ]),
        ]);
  }

  static buildText({
    required String title,
    TextStyle? titleStyle,
  }) {
    return Container(
      child: Row(
        children: [
          Expanded(child: Text(title)),
        ],
      ),
    );
  }
}
