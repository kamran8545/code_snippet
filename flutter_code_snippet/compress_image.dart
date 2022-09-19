/// Import flutter_image_compress package in pubspec.yaml



import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';


Future<File> compressImage(File file) async {

  CompressFormat compressFormat = CompressFormat.jpeg;
  try {
    final filePath = file.absolute.path;
    // Create output file path
    int lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    if (lastIndex == -1) {
      lastIndex = filePath.lastIndexOf(new RegExp(r'.png'));
      compressFormat = CompressFormat.png;
    }
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    File? compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        quality: 50, format: compressFormat);

    if(compressedImage!=null){
      return compressedImage;
    }
    else {
      return file;
    }
  } catch (e) {
    return file;
  }
}
