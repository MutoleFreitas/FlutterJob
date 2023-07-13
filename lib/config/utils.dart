import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void saveBase64ImageToFile(String base64String, String filePath) {
  // Remove the data:image/jpeg;base64, prefix to get the actual base64 data
  String data = base64String.replaceFirst(RegExp('data:image/[^;]+;base64,'), '');

  // Decode the base64 data into bytes
  Uint8List bytes = base64.decode(data);

  // Write the bytes to the file
  File(filePath).writeAsBytesSync(bytes);
}

Future<void> downloadFile(String url, String savePath) async {
  final response = await http.get(Uri.parse(url));
  final file = File(savePath);

  await file.writeAsBytes(response.bodyBytes);
}

