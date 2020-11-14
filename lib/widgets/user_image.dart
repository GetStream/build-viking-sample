import 'package:build_viking/assets.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage({Key key, @required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    final bool canDisplayImage = image != null && image.isNotEmpty;
    if (canDisplayImage) {
      return CircleAvatar(
        backgroundColor: Colors.white,
        radius: 32,
        child: Center(
          child: Image.network(
            image,
            height: 56.0,
          ),
        ),
      );
    } else {
      return CircleAvatar(
        backgroundColor: Colors.white,
        radius: 32,
        child: Center(
          child: Image.asset(
            Assets.vikingDash,
            height: 56.0,
          ),
        ),
      );
    }
  }
}
