import 'package:build_viking/screen/conversation_screen.dart';
import 'package:build_viking/utils/utils.dart';
import 'package:build_viking/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class UsersScreen extends StatelessWidget {
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
    final client = StreamChat.of(context).client;
    final user = StreamChat.of(context).user;
    return BrandedScaffold(
      child: FutureBuilder(
        future: client.queryUsers(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QueryUsersResponse> snapshot,
        ) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.users.length,
              itemBuilder: (BuildContext context, int index) {
                final data = snapshot.data.users[index];
                return ChatItem(
                  image: data.extraData['image'] ?? "",
                  subtitle:
                      "Last seen: ${formatDate(context, data.lastActive)}",
                  name: data.extraData['name'] ?? "",
                  onTap: () async {
                    final channel = client.channel("messaging",
                        id: "${data.id}-${user.id}",
                        extraData: {
                          "members": [data.id, user.id]
                        });
                    await channel.create();
                    //TODO(Nash):Pushing this route results in a black Screen
                    context.nav.push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return StreamChannel(
                            channel: channel,
                            child: ConversationScreen(),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Container(
                height: 200.0,
                width: 200.0,
                child: BuildVikingCard(
                  child: Center(
                    child: Text(
                      "We are having some difficulties loading users",
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Container(
                height: 200.0,
                width: 200.0,
                child: BuildVikingCard(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
