import 'package:build_viking/screen/users_screen.dart';
import 'package:build_viking/utils/utils.dart';
import 'package:build_viking/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatHomeScreen extends StatelessWidget {
  Widget buildMessageCard(String message, [double bottomPadding = 12.0]) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: bottomPadding),
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
    return BrandedScaffold(
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
            return InkWell(
              onTap: () => context.nav.push(
                MaterialPageRoute(
                  builder: (context) => UsersScreen(),
                ),
              ),
              child: buildMessageCard(
                "Tap to get started.",
                viewPadding.bottom + 24.0,
              ),
            );
          },
          channelPreviewBuilder: (
            BuildContext context,
            Channel channel,
          ) {
            return ChatItem(
              name: channel.createdBy.name,
              lastMessage: MaterialLocalizations.of(context).formatMediumDate(
                channel.lastMessageAt,
              ),
              onTap: () {},
              image: channel.createdBy.extraData['image'] ?? '',
            );
          },
        ),
      ),
    );
  }
}
