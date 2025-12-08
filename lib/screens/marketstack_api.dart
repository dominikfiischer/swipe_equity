import 'dart:convert';
import 'package:http/http.dart' as http;
import 'stock.dart';
import 'sp500_symbols.dart';

class MarketstackAPI {
  final String apiKey = '72b24fd0d494a5db3335121838ada599';
  

    final url = Uri.parse(
        'http://api.marketstack.com/v2/eod?access_key=$apiKey&symbols=$symbols'
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      final List rawData = jsonData["data"];

      return rawData.map((e) => Stock.fromJson(e)).toList();
    } else {
      throw Exception('API error: ${response.statusCode}');
    }
  }
}
