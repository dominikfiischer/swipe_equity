class Stock {
  final String symbol;
  // 'price' typically represents the closing price in EOD data
  final double price;
  final double? open;
  final double? high;
  final double? low;
  final int? volume;

  Stock({
    required this.symbol,
    required this.price,
    this.open,
    this.high,
    this.low,
    this.volume
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['symbol'],
      // Use null-aware operator (?.) and default to 0.0 if the field is missing
      price: json['price']?.toDouble() ?? 0.0,
      open: json['open']?.toDouble(),
      high: json['high']?.toDouble(),
      low: json['low']?.toDouble(),
      // Volume is explicitly cast to an integer
      volume: json['volume'] as int?,
    );
  }
}