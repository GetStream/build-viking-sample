import 'package:build_viking/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key key,
    @required this.message,
    @required this.timeStamp,
    @required this.name,
    this.imageUrl,
    this.isSender = false,
  })  : assert(message != null),
        assert(timeStamp != null),
        assert(name != null),
        super(key: key);

  final bool isSender;
  final String message;
  final String timeStamp;
  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final bool hasImage = imageUrl != null && imageUrl.isNotEmpty;
    final MainAxisAlignment rowAlignment =
        isSender ? MainAxisAlignment.end : MainAxisAlignment.start;

    return DefaultTextStyle(
      style: GoogleFonts.inter(fontSize: 14.0, color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: rowAlignment,
          children: [
            const SizedBox(width: 6.0),
            if (!isSender)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 16,
                  child: Center(
                    child: hasImage
                        ? Image.network(
                            imageUrl,
                            height: 56.0,
                          )
                        : Image.asset(
                            Assets.vikingDash,
                            height: 56.0,
                          ),
                  ),
                ),
              ),
            SizedBox(
              width: 150.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    color: isSender ? Color(0xFF4FC6F9) : Color(0xFF000040),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                        bottomLeft: Radius.circular(isSender ? 12.0 : 0.0),
                        bottomRight: Radius.circular(isSender ? 0.0 : 12.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: rowAlignment,
                    children: [
                      Text(
                        timeStamp,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Text(
                        isSender ? "You" : name,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
