import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app.dart';

void main() async {
  await initializeDateFormatting();

  runApp(const App());
}
