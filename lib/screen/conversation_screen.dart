import 'package:build_viking/assets.dart';
import 'package:build_viking/utils/utils.dart';
import 'package:build_viking/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ConversationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final channel = StreamChannel.of(context).channel;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: BackButton(
          color: Colors.white,
        ),
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 20.0,
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
                  ChannelName(),
                  StreamBuilder<DateTime>(
                    stream: channel.lastMessageAtStream,
                    initialData: channel.lastMessageAt,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return SizedBox();
                      }
                      final jiffyDate = formatDate(context, snapshot.data);
                      return Text(
                        'Active $jiffyDate',
                        style: StreamChatTheme.of(context)
                            .channelTheme
                            .channelHeaderTheme
                            .lastMessageAt
                            .copyWith(color: Colors.white),
                      );
                    },
                  )
                ],
              )
            ],
          ),
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
          MessageInput(
            inputTextStyle: GoogleFonts.inter(color: Colors.white),
            attachmentIconColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
