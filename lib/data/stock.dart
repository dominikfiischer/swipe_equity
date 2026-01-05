class Stock {
  final String name;
  final String ticker; // This was missing or named differently
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
    required this.name,
    required this.ticker,
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

  // This converts your JSON maps into Stock objects
  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      name: json['name'] ?? '',
      ticker: json['ticker'] ?? '', // Make sure your JSON uses the key "ticker"
      marketCap: json['marketCap'],
      dividendYield: json['dividendYield'],
      peRatio: json['peRatio'],
      averageVolume: json['averageVolume'],
      founded: json['founded'],
      employees: json['employees'],
      ceo: json['ceo'],
      website: json['website'],
      about: json['about'],
    );
  }
}