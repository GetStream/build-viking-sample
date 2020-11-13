import 'package:build_viking/assets.dart';
import 'package:build_viking/services/api_service.dart';
import 'package:build_viking/utils/utils.dart';
import 'package:build_viking/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
        service: HttpAPIService(),
        child: ConversationScreen(),
      ),
    );
  }
}

class BuildVikings extends StatefulWidget {
  @override
  _BuildVikingsState createState() => _BuildVikingsState();
}

class _BuildVikingsState extends State<BuildVikings> {
  ValueNotifier<bool> _showingCamera = ValueNotifier(false);

  void _onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((onScan));
  }

  void onScan(String data) {
    //TODO(Nash): Implement when api becomes available
    // context.apiService.getUserProfile(data);
  }

  Future<void> showCamera(bool value) async {
    await Permission.camera.request();
    _showingCamera.value = !value;
  }

  Widget _buildScanCard() {
    return ValueListenableBuilder<bool>(
      valueListenable: _showingCamera,
      builder: (context, bool value, _) {
        return AnimatedSwitcher(
          duration: kThemeAnimationDuration,
          child: value
              ? BuildVikingCard(
                  key: ValueKey<String>("barcode-scanner"),
                  onTap: () => _showingCamera.value = !value,
                  child: Container(
                    height: 132.0,
                    width: 160.0,
                    child: QRView(
                      key: GlobalKey(),
                      onQRViewCreated: _onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                        borderColor: Colors.red,
                        borderRadius: 10,
                        borderLength: 30,
                        borderWidth: 10,
                        cutOutSize: 300,
                      ),
                    ),
                  ),
                )
              : BuildVikingCard(
                  key: ValueKey<String>("scan-ticket"),
                  onTap: () => showCamera(value),
                  child: _ScanTicket(),
                ),
        );
      },
    );
  }

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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                Assets.flutterVikingsLogo,
                height: 173.0,
              ),
              const SizedBox(height: 48.0),
              _buildScanCard(),
              Flexible(child: FractionallySizedBox(heightFactor: 0.3)),
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

class _ScanTicket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          Assets.barcode,
          height: 64.0,
        ),
        const SizedBox(height: 12.0),
        Text(
          "Scan your ticket",
          style: GoogleFonts.caesarDressing(
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          "Tap to begin".toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.white.withOpacity(0.25),
          ),
        ),
      ],
    );
  }
}

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
                  (index) =>
                      index.isEven ? _TheirMessageItem() : _YourMessageItem(),
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

class _TheirMessageItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(width: 6.0),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 16,
            child: Center(
              child: Image.asset(
                Assets.vikingDash,
                height: 56.0,
              ),
            ),
          ),
          const SizedBox(width: 6.0),
          SizedBox(
            width: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Foo"),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Nash",
                      style: GoogleFonts.inter(
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "2:14 pm",
                      style: GoogleFonts.inter(
                        fontSize: 12.0,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _YourMessageItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(width: 6.0),
          SizedBox(
            width: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(0.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Foo"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "2:14 pm",
                      style: GoogleFonts.inter(
                        fontSize: 12.0,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "Nash",
                      style: GoogleFonts.inter(
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
