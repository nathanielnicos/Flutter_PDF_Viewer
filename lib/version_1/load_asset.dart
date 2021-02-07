import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class LoadAsset extends StatefulWidget {
  @override
  _LoadAssetState createState() => _LoadAssetState();
}

class _LoadAssetState extends State<LoadAsset> {
  String pdfAssets = "assets/practical_flutter.pdf";
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
    final doc = await PDFDocument.fromAsset(pdfAssets);
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
