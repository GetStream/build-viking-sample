import 'package:build_viking/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    Key key,
    @required this.name,
    @required this.lastMessage,
    @required this.onTap,
    @required this.image,
  })  : assert(name != null),
        assert(lastMessage != null),
        assert(image != null),
        super(key: key);

  final String name;
  final String lastMessage;
  final VoidCallback onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    final bool canDisplayImage = image != null && image.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 32,
          child: Center(
            child: canDisplayImage
                ? Image.network(
                    image,
                    height: 56.0,
                  )
                : Image.asset(
                    Assets.vikingDash,
                    height: 56.0,
                  ),
          ),
        ),
        title: Text(
          name,
          style: GoogleFonts.caesarDressing(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          lastMessage,
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
