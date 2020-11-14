import 'package:build_viking/assets.dart';
import 'package:build_viking/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatHomeScreen extends StatelessWidget {
  Widget buildMessageCard(String message, [double bottomPadding = 12.0]) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          bottom: bottomPadding,
        ),
        height: 200.0,
        width: 200.0,
        child: BuildVikingCard(
          child: Center(
            child: Text(
              message,
              style: GoogleFonts.inter(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 14.0,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.of(context).viewPadding;
    final id = StreamChat.of(context).user.id;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: viewPadding.bottom,
            child: Image.asset(
              Assets.vikingVillage,
              fit: BoxFit.fitWidth,
            ),
          ),
          Column(
            children: [
              SizedBox(height: viewPadding.top + 12.0),
              VikingChatLogo(),
              const SizedBox(height: 12.0),
              Expanded(
                child: ChannelsBloc(
                  child: ChannelListView(
                    filter: {
                      'members': {
                        '\$in': [id],
                      }
                    },
                    sort: [SortOption('last_message_at')],
                    pagination: PaginationParams(
                      limit: 20,
                    ),
                    channelWidget: Container(),
                    errorBuilder: (error) {
                      return buildMessageCard(
                        "We could not load your messages at this time.",
                        viewPadding.bottom + 24.0,
                      );
                    },
                    emptyBuilder: (context) {
                      return buildMessageCard(
                        "Select new to get started.",
                        viewPadding.bottom + 24.0,
                      );
                    },
                    channelPreviewBuilder: (
                      BuildContext context,
                      Channel channel,
                    ) {
                      return ChatItem(
                        name: channel.createdBy.name,
                        lastMessage:
                            MaterialLocalizations.of(context).formatMediumDate(
                          channel.lastMessageAt,
                        ),
                        onTap: () {},
                        image: channel.createdBy.extraData['image'] ?? '',
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: viewPadding.bottom + 48)
            ],
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(bottom: viewPadding.bottom),
              width: double.maxFinite,
              color: Theme.of(context).primaryColor,
              child: Image.asset(
                Assets.streamBanner,
                height: 40.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
