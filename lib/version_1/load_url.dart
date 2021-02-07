import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class LoadUrl extends StatefulWidget {
  @override
  _LoadUrlState createState() => _LoadUrlState();
}

class _LoadUrlState extends State<LoadUrl> {
  String pdfUrl = "http://www.pdf995.com/samples/pdf.pdf";
  PDFDocument _doc;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _initPdf();
  }

  _initPdf() async {
    setState(() {
      _loading = true;
    });
    final doc = await PDFDocument.fromURL(pdfUrl);
    setState(() {
      _doc = doc;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My PDF App"),
        backgroundColor: Colors.teal,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PDFViewer(document: _doc),
    );
  }
}
