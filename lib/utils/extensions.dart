import 'package:build_viking/services/services.dart';
import 'package:build_viking/utils/providers.dart';
import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  APIService get apiService => ApiProvider.of(this);
  NavigatorState get nav => Navigator.of(this);
}
