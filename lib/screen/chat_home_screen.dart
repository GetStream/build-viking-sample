import 'package:build_viking/assets.dart';
import 'package:build_viking/screen/conversation_screen.dart';
import 'package:build_viking/utils/utils.dart';
import 'package:build_viking/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChatHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.of(context).viewPadding;
    return Scaffold(
      body: Stack(
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
          ListView(
            children: [
              SizedBox(height: viewPadding.top),
              VikingChatLogo(),
              const SizedBox(height: 24.0),
              ...List.generate(
                12,
                (index) => ChatItem(
                  name: "Nick Parsons",
                  lastMessage: "4 Days remaining",
                  onTap: () => context.nav.push(
                    MaterialPageRoute(
                      builder: (context) => ConversationScreen(),
                    ),
                  ),
                  image: "",
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
