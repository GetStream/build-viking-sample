import 'package:build_viking/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    Key key,
    @required this.subtitle,
    @required this.onTap,
    @required this.image,
    this.name,
  })  : assert(subtitle != null),
        assert(image != null),
        super(key: key);
  final Widget name;
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
        title: name ??
            ChannelName(
              textStyle: GoogleFonts.caesarDressing(
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
