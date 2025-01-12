import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future<dynamic> getData() async {
    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      /// json.decode(source) == jsonDecode(source)

      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
