import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart'; // Needed for debugPrint

import '../../../data/stock.dart';

class TickerLoader {

  Future<List<Stock>> fetchStocks() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/ticker.json');

      final List rawData = jsonDecode(jsonString);

      return rawData.map((e) => Stock.fromJson(e)).toList();

    } catch (e) {
      debugPrint('Error loading ticker.json: $e');
      return [];
    }
  }
}