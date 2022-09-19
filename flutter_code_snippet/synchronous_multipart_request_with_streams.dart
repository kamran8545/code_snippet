  



Future<Map<String,dynamic>> getData({required String url})async{
    MultipartRequest request = MultipartRequest('POST', Uri.parse(url));
    request.fields['key'] = "value";
    request.files.add(await MultipartFile.fromPath(
        'key', "file_path"));

    StreamedResponse streamedResponse = await request.send();
    ByteStream byteStream = streamedResponse.stream;
    Stream<String> streamStr = byteStream.transform(utf8.decoder);
    Map<String,dynamic> requestResponse = {};
    await for(String response in streamStr){
    requestResponse = jsonDecode(response);
    }
    return requestResponse;
  }
