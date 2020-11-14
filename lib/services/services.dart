import 'package:build_viking/models/user_model.dart';

abstract class APIService {
  Future<VikingUser> getUserProfile(final String ticketID);
}
