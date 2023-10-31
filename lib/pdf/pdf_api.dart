import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    Directory dir;
    File file;

    if (Platform.isAndroid) {
      final String path = (await getExternalStorageDirectory())!.path;
      file = File('$path/$name');
    } else {
      dir = await getApplicationDocumentsDirectory();
      file = File('${dir.path}/$name');
    }

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
