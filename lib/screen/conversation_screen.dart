import 'package:build_viking/assets.dart';
import 'package:build_viking/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            child: ListView(
              children: [
                ...List.generate(
                  6,
                  (index) => index.isEven
                      ? MessageItem(
                          isSender: true,
                          name: "Nash",
                          timeStamp: "15:18 pm",
                          message: "Hello there",
                        )
                      : MessageItem(
                          name: "Nick",
                          timeStamp: "15:18 pm",
                          message: "Hello Nash",
                        ),
                )
              ],
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}
