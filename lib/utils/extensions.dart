import 'package:build_viking/services/services.dart';
import 'package:build_viking/utils/providers.dart';
import 'package:flutter/material.dart';

extension APIProviderExtension on BuildContext {
  APIService get apiService => ApiProvider.of(this);
}
