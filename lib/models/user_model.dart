import 'package:meta/meta.dart';

class VikingUser {
  VikingUser({
    @required this.name,
    @required this.image,
    @required this.token,
  })  : assert(name != null && name.isNotEmpty),
        assert(token != null && token.isNotEmpty),
        assert(token != null);

  factory VikingUser.fromJson(Map<String, dynamic> data) {
    return VikingUser(
      name: data['name'],
      image: data['image'] ?? "",
      token: data['token'],
    );
  }

  final String name;
  final String image;
  final String token;

  @override
  String toString() {
    return 'VikingUser{name: $name, image: $image, token: $token}';
  }
}
