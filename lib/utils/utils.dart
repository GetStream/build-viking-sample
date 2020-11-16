import 'package:flutter/material.dart';

export './extensions.dart';
export './providers.dart';

String formatDate(BuildContext context, DateTime time) {
  if (time == null) {
    return "Never";
  } else {
    return MaterialLocalizations.of(context).formatMediumDate(time);
  }
}
