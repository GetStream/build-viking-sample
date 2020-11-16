import 'package:build_viking/assets.dart';
import 'package:build_viking/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BrandedScaffold extends StatelessWidget {
  const BrandedScaffold({
    Key key,
    @required this.child,
    this.header,
  })  : assert(child != null),
        super(key: key);
  final Widget child;
  final Widget header;

  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.of(context).viewPadding;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
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
            children: [
              SizedBox(height: viewPadding.top + 12.0),
              VikingChatLogo(),
              if (header != null) header,
              const SizedBox(height: 12.0),
              Expanded(
                child: child,
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
