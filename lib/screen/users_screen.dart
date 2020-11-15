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
    return BrandedScaffold(
      child: FutureBuilder(
        future: StreamChat.of(context).client.queryUsers(),
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
                  image: data.extraData['image'],
                  lastMessage:
                      MaterialLocalizations.of(context).formatMediumDate(
                    data.lastActive,
                  ),
                  name: data.extraData['name'],
                  onTap: null,
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
                    child: CircularProgressIndicator(),
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
