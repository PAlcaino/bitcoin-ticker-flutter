import 'package:http/http.dart' as http;

class Networking {
  Future<dynamic> getData(Uri uri) async {
    if (uri == null) {
      throw Exception("uri parameter cant be null");
    }
    return await http.get(uri);
  }
}
