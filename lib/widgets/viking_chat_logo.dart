import 'package:build_viking/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VikingChatLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(Assets.chatLogo, height: 56.0),
        SizedBox(height: 8.0),
        RichText(
          text: TextSpan(
            text: "Viking",
            style: GoogleFonts.caesarDressing(
              fontSize: 24.0,
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: "Chat",
                style: GoogleFonts.inter(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
