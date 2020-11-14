import 'package:build_viking/screen/home_screen.dart';
import 'package:build_viking/services/api_service.dart';
import 'package:build_viking/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(App());
}

class App extends StatelessWidget {
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
      home: ApiProvider(
        service: HttpAPIService(http.Client()),
        child: BuildVikings(),
      ),
    );
  }
}
