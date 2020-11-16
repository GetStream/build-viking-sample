import 'package:build_viking/assets.dart';
import 'package:build_viking/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ConversationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: BackButton(),
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 24.0,
              backgroundColor: Colors.white,
              child: Center(
                child: Image.asset(
                  Assets.vikingDash,
                  height: 56.0,
                ),
              ),
            ),
            const SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nash R",
                  style: GoogleFonts.caesarDressing(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Active Now",
                  style: GoogleFonts.inter(
                    fontSize: 12.0,
                    color: Colors.white.withOpacity(0.64),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: MessageListView(
              messageBuilder: (BuildContext context, MessageDetails details,
                  List<Message> messages) {
                if (details.isMyMessage) {
                  return MessageItem(
                    name: details.message.user.name,
                    timeStamp: MaterialLocalizations.of(context)
                        .formatMediumDate(details.message.createdAt),
                    message: details.message.text,
                    imageUrl: details.message.user.extraData['image'],
                    isSender: true,
                  );
                }
                return MessageItem(
                  name: details.message.user.name,
                  timeStamp: MaterialLocalizations.of(context)
                      .formatMediumDate(details.message.createdAt),
                  message: details.message.text,
                  imageUrl: details.message.user.extraData['image'],
                );
              },
            ),
          ),
          MessageInput(),
        ],
      ),
    );
  }
}
