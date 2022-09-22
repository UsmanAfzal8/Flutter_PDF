import 'package:flutter/material.dart';

import 'api/pdf_api.dart';
import 'api/pdf_show.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('PDF Generate'),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(onPressed: () async {
              final pdfFile = await PdfInvoiceApi.generate();

                    PdfApi.openFile(pdfFile);
            }, child: const Text('Print')),
          ],
        ),
      ),
    );
  }
}
