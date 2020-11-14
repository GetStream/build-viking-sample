import 'package:build_viking/assets.dart';
import 'package:build_viking/utils/utils.dart';
import 'package:build_viking/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BuildVikings extends StatefulWidget {
  @override
  _BuildVikingsState createState() => _BuildVikingsState();
}

class _BuildVikingsState extends State<BuildVikings> {
  ValueNotifier<bool> _showingCamera = ValueNotifier(false);
  ValueNotifier<bool> _hasError = ValueNotifier(false);
  bool canMakeRequest = true;

  void _onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((onScan));
  }

  Future<void> onScan(String data) async {
    if (canMakeRequest) {
      canMakeRequest = false;
      try {
        await context.apiService.getUserProfile(data);
        canMakeRequest = true;
      } catch (e) {
        canMakeRequest = true;
        _hasError.value = true;
        print(e);
      }
    }
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
                  child: _TicketScanner(
                    onQRViewCreated: _onQRViewCreated,
                    hasError: _hasError,
                  ),
                )
              : BuildVikingCard(
                  key: ValueKey<String>("scan-ticket"),
                  onTap: () => showCamera(value),
                  child: _InfoCard(),
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

class _TicketScanner extends StatelessWidget {
  const _TicketScanner({
    Key key,
    this.hasError,
    this.onQRViewCreated,
  })  : assert(hasError != null),
        assert(onQRViewCreated != null),
        super(key: key);

  final ValueNotifier<bool> hasError;
  final QRViewCreatedCallback onQRViewCreated;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132.0,
      width: 160.0,
      child: ValueListenableBuilder(
        valueListenable: hasError,
        builder: (BuildContext context, value, _) {
          if (!value) {
            return QRView(
              key: GlobalKey(),
              onQRViewCreated: onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            );
          } else {
            return InkWell(
              onTap: () => hasError.value = !hasError.value,
              child: Center(
                child: Text(
                  "We are unable to scan your ticket at this time.",
                  style: GoogleFonts.inter(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.6),
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

class _InfoCard extends StatelessWidget {
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
