import 'package:build_viking/services/services.dart';

class HttpAPIService implements APIService {
  @override
  Future<void> getUserProfile(String ticketID) {
    final _rawId = parseTicketUrl(ticketID);
    throw UnimplementedError();
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
