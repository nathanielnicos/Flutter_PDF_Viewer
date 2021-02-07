import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ApiService {
  static final String pdfUrl = "http://www.pdf995.com/samples/pdf.pdf";

  static Future<String> loadPdf() async {
    var response = await http.get(pdfUrl);
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/data.pdf");
    
    file.writeAsBytesSync(response.bodyBytes, flush: true);
    return file.path;
  }
}