import 'package:build_viking/api.dart';
import 'package:build_viking/screen/home_screen.dart';
import 'package:build_viking/services/api_service.dart';
import 'package:build_viking/utils/utils.dart';
import 'package:build_viking/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  final service = HttpAPIService(http.Client(), Client(API.streamApi));
  runApp(App(service: service));
}

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.service,
  })  : assert(service != null),
        super(key: key);

  final HttpAPIService service;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Build Viking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF000040),
        scaffoldBackgroundColor: Color(0xFF000A51),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (BuildContext context, Widget child) {
        return StreamChat(
          streamChatThemeData: StreamChatThemeData(
            ownMessageTheme: MessageTheme(
              messageBackgroundColor: Color(0xFF4FC6F9),
              createdAt: TextStyle(
                color: Colors.white,
              ),
              messageText: TextStyle(
                color: Colors.white,
              ),
            ),
            otherMessageTheme: MessageTheme(
              messageBackgroundColor: Color(0xFF000040),
              createdAt: TextStyle(
                color: Colors.white,
              ),
              messageText: TextStyle(
                color: Colors.white,
              ),
            ),
            channelTheme: ChannelTheme(
              inputBackground: Color(0xFF000A51),
            ),
            backgroundColor: Color(0xFF000A51),
            defaultUserImage: (_, user) => UserImage(
              image: user.extraData['image'] ?? "",
            ),
          ),
          client: service.streamClient,
          child: child,
        );
      },
      home: ApiProvider(
        service: service,
        child: BuildVikings(),
      ),
    );
  }
}
