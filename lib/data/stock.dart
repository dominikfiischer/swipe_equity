// lib/data/stock.dart
class Stock {
  final String symbol;
  final String name;
  final double price;
  // 🛠️ FIX: Add '?' to make these fields nullable
  final String? marketCap;
  final String? dividendYield;
  final String? peRatio;
  final String? averageVolume;
  final String? founded;
  final String? employees;
  final String? ceo;
  final String? website;
  final String? about;

  Stock({
    required this.symbol,
    required this.name,
    required this.price,
    this.marketCap,
    this.dividendYield,
    this.peRatio,
    this.averageVolume,
    this.founded,
    this.employees,
    this.ceo,
    this.website,
    this.about,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['symbol']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown',
      price: (json['price'] ?? 0).toDouble(),
      marketCap: json['marketCap']?.toString(),
      dividendYield: json['dividendYield']?.toString(),
      peRatio: json['peRatio']?.toString(),
      averageVolume: json['averageVolume']?.toString(),
      founded: json['founded']?.toString(),
      employees: json['employees']?.toString(),
      ceo: json['ceo']?.toString(),
      website: json['website']?.toString(),
      about: json['about']?.toString(),
    );
  }
}