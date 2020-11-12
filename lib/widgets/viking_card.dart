import 'package:flutter/material.dart';

class BuildVikingCard extends StatelessWidget {
  const BuildVikingCard({
    Key key,
    @required this.child,
    @required this.onTap,
  })  : assert(onTap != null),
        assert(child != null),
        super(key: key);
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 36.0,
              horizontal: 24.0,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
