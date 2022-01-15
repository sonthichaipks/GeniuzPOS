import 'package:http/http.dart' as http;

Future<String> wsList(String url) async {
  try {
    if (url != null) {
      var request = http.Request('GET', Uri.parse('$url'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return await response.stream.bytesToString();
      } else if (response.statusCode == 204) {
        return 'OK';
      } else if (response.statusCode == 401) {
      } else {}
    }
  } catch (e) {}
  return null;
}

Future<String> wsExec(String url) async {
  try {
    if (url != null) {
      http.put(Uri.parse('$url'), headers: {"Accept": "application/json"}).then(
          (result) {
        return result;
      });
    }
  } catch (e) {}
  return null;
}
