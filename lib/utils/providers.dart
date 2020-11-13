import 'package:build_viking/services/services.dart';
import 'package:flutter/material.dart';

class ApiProvider extends InheritedWidget {
  const ApiProvider({
    Key key,
    @required Widget child,
    @required this.service,
  })  : assert(child != null),
        assert(service != null),
        super(key: key, child: child);

  final APIService service;

  static APIService of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>().service;
  }

  @override
  bool updateShouldNotify(ApiProvider old) {
    return old.service != service;
  }
}
