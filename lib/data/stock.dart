class Stock {
  final String name;
  final String ticker;
  final String? marketCap;
  final String? dividendYield;
  final String? peRatio;
  final String? ceo;
  final String? about;
  // 🚀 New Fields
  final String? industry;
  final String? high52;
  final String? low52;
  final String? profitMargin;

  Stock({
    required this.name,
    required this.ticker,
    this.marketCap,
    this.dividendYield,
    this.peRatio,
    this.ceo,
    this.about,
    this.industry,
    this.high52,
    this.low52,
    this.profitMargin,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      name: json['name'] ?? '',
      ticker: json['ticker'] ?? '',
      marketCap: json['marketCap'],
      dividendYield: json['dividendYield'],
      peRatio: json['peRatio'],
      ceo: json['ceo'],
      about: json['about'],
      industry: json['industry'],
      high52: json['high52'],
      low52: json['low52'],
      profitMargin: json['profitMargin'],
    );
  }
}