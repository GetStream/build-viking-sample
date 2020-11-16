import 'package:build_viking/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    Key key,
    @required this.name,
    @required this.subtitle,
    @required this.onTap,
    @required this.image,
  })  : assert(name != null),
        assert(subtitle != null),
        assert(image != null),
        super(key: key);

  final String name;
  final String subtitle;
  final VoidCallback onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        onTap: onTap,
        leading: UserImage(image: image),
        title: Text(
          name,
          style: GoogleFonts.caesarDressing(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 12.0,
            color: Colors.white.withOpacity(0.3),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          size: 18.0,
          color: Colors.white.withOpacity(0.65),
        ),
      ),
    );
  }
}
