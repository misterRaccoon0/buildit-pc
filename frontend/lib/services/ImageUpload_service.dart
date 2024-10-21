import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

class ImageUploadService {
  final String uploadUrl = 'http://10.0.2.2:8000/api/upload';

  Future<String?> uploadImage(File imageFile) async {
    try {
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      
      var uri = Uri.parse(uploadUrl); 

      var request = http.MultipartRequest('POST', uri);
      var multipartFile = http.MultipartFile(
        'image', 
        stream, 
        length, 
        filename: basename(imageFile.path),
      );
      
      request.files.add(multipartFile);

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print('Response data: $responseData'); // Log the response data
        var jsonResponse = jsonDecode(responseData);
        return 'http://10.0.2.2:8000${jsonResponse['path']}'; // Ensure the full URL is returned
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}