import 'package:http/http.dart' as http;

Future<String> fetchBookmarksHtml(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode != 200) {
    throw Exception("OpenRice returned status code ${response.statusCode}");
  }
  return response.body;
}
