import 'dart:convert';

import 'package:build_viking/api.dart';
import 'package:build_viking/models/user_model.dart';
import 'package:build_viking/services/services.dart';
import 'package:http/http.dart' as http;

class HttpAPIService implements APIService {
  const HttpAPIService(this.client) : assert(client != null);

  final http.Client client;

  @override
  Future<VikingUser> getUserProfile(String ticketID) async {
    final _rawId = parseTicketUrl(ticketID);
    return await _fetchUserAccount(_rawId);
  }

  Future<VikingUser> _fetchUserAccount(final String ticketID) async {
    try {
      print(ticketID);
      final http.Response response = await client.post(
        API.apiUrl,
        body: jsonEncode({
          "id": ticketID, //'pFbDZCGsZIrrAmqELjz6F8w'
        }), // TODO:Replace with variable once API is fixed.
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final VikingUser user = VikingUser.fromJson(
          jsonDecode(response.body)['data'],
        );
        return user;
      } else {
        throw StateError("API returned an invalid status code.");
      }
    } catch (error) {
      throw StateError("API returned an invalid response. Please see logs.");
    }
  }

  String parseTicketUrl(final String url) {
    if (url.contains('https://passbook.tito.io/')) {
      final _path = Uri.dataFromString(url).pathSegments;
      return _path[_path.length - 1];
    } else {
      return url;
    }
  }
}
