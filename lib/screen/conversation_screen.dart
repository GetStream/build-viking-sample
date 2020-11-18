import 'package:build_viking/assets.dart';
import 'package:build_viking/utils/utils.dart';
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
              Expanded(
                child: Column(
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
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: MessageListView(
              dateDividerBuilder: (date) {
                return Theme(
                  data: ThemeData(
                    textTheme: TextTheme(
                      headline6: TextStyle(color: Colors.white)
                    ),
                  ),
                  child: DateDivider(
                    dateTime: date,
                  ),
                );
              },
              messageBuilder: (
                BuildContext context,
                MessageDetails details,
                List<Message> messages,
              ) {
                final theme = StreamChatTheme.of(context);
                return Column(
                  crossAxisAlignment: details.isMyMessage
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    MessageWidget(
                      message: details.message,
                      messageTheme: details.isMyMessage
                          ? theme.ownMessageTheme
                          : theme.otherMessageTheme,
                      showUserAvatar: details.isMyMessage
                          ? DisplayWidget.gone
                          : (details.isNextUser
                              ? DisplayWidget.hide
                              : DisplayWidget.show),
                      showTimestamp: false,
                      showSendingIndicator: details.isNextUser
                          ? DisplayWidget.hide
                          : DisplayWidget.show,
                      showEditMessage: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                      ),
                      showUsername: false,
                      reverse: details.isMyMessage,
                    ),
                    if (!details.isNextUser)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: details.isMyMessage ? 24.0 : 68,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                MaterialLocalizations.of(context)
                                    .formatMediumDate(
                                        details.message.createdAt),
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              ),
                            ),
                            Text(
                              details.isMyMessage
                                  ? "You"
                                  : details.message.user.name,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                          mainAxisAlignment: details.isMyMessage
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                        ),
                      ),
                  ],
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
