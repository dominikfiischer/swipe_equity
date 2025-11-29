// Path: lib/models/asset_data.dart

/// --- Core Data Models (Translated from TypeScript Interfaces) ---

enum AppScreen {
  welcome,
  swipe,
  investments,
  detail,
  profile,
  investing,
  search,
  userProfile,
  brokers,
}

class Stock {
  final String id;
  final String name;
  final String symbol;
  final String sector;
  final String logo;
  final double price;
  final double change;
  final double changePercent;
  final String description;
  final double pe;
  final double dividend;
  final double growth;
  final String marketCap;
  final String revenue;
  final String employees;
  final String founded;
  final String headquarters;
  final String? ceo;
  final String? website;

  Stock({
    required this.id,
    required this.name,
    required this.symbol,
    required this.sector,
    required this.logo,
    required this.price,
    required this.change,
    required this.changePercent,
    required this.description,
    required this.pe,
    required this.dividend,
    required this.growth,
    required this.marketCap,
    required this.revenue,
    required this.employees,
    required this.founded,
    required this.headquarters,
    this.ceo,
    this.website,
  });
}

class WatchlistEntry {
  final Stock stock;
  final double entryPrice;
  final String entryDate;
  final double currentReturn;
  final double currentReturnPercent;

  WatchlistEntry({
    required this.stock,
    required this.entryPrice,
    required this.entryDate,
    required this.currentReturn,
    required this.currentReturnPercent,
  });
}

class UserStats {
  final int totalStocks;
  final double avgReturn;
  final String bestPerformer;
  final int followers;
  final int following;

  UserStats({
    required this.totalStocks,
    required this.avgReturn,
    required this.bestPerformer,
    required this.followers,
    required this.following,
  });
}

class UserActivity {
  final String id;
  final String type; // 'added' or 'liked'
  final Stock stock;
  final String timestamp;

  UserActivity({
    required this.id,
    required this.type,
    required this.stock,
    required this.timestamp,
  });
}

class UserProfile {
  final String id;
  final String name;
  final String avatar;
  final String bio;
  final String joinedDate;
  final bool isPublic;
  final List<WatchlistEntry> watchlist;
  final List<UserActivity> activities;
  final UserStats stats;

  UserProfile({
    required this.id,
    required this.name,
    required this.avatar,
    required this.bio,
    required this.joinedDate,
    required this.isPublic,
    required this.watchlist,
    required this.activities,
    required this.stats,
  });
}

class FriendActivity {
  final String id;
  final String friendName;
  final String friendAvatar;
  final Stock stock;
  final String action; // 'liked' or 'invested'
  final String timestamp;

  FriendActivity({
    required this.id,
    required this.friendName,
    required this.friendAvatar,
    required this.stock,
    required this.action,
    required this.timestamp,
  });
}

// --- Mock Data Initialization (Dart equivalent of your React mocks) ---

// Define Mock Data so the main app can run
final mockTrendingStocks = [
  Stock(
    id: 'trending-1',
    name: 'Tesla Inc.',
    symbol: 'TSLA',
    sector: 'Automobil',
    logo: 'https://logo.clearbit.com/tesla.com',
    price: 248.50,
    change: 12.30,
    changePercent: 5.20,
    description: 'Elektrofahrzeuge und Energiespeicher',
    pe: 65.2,
    dividend: 0,
    growth: 35.8,
    marketCap: '790B',
    revenue: '96.8B',
    employees: '140,000',
    founded: '2003',
    headquarters: 'Austin, TX',
  ),
  Stock(
    id: 'trending-2',
    name: 'NVIDIA Corporation',
    symbol: 'NVDA',
    sector: 'Technologie',
    logo: 'https://logo.clearbit.com/nvidia.com',
    price: 875.30,
    change: -15.20,
    changePercent: -1.71,
    description: 'Grafikprozessoren und KI-Chips',
    pe: 72.1,
    dividend: 0.16,
    growth: 58.4,
    marketCap: '2.1T',
    revenue: '60.9B',
    employees: '29,600',
    founded: '1993',
    headquarters: 'Santa Clara, CA',
  ),
  Stock(
    id: 'trending-3',
    name: 'Apple Inc.',
    symbol: 'AAPL',
    sector: 'Technologie',
    logo: 'https://logo.clearbit.com/apple.com',
    price: 192.75,
    change: 2.45,
    changePercent: 1.29,
    description: 'Consumer Electronics und Software',
    pe: 28.9,
    dividend: 0.25,
    growth: 8.1,
    marketCap: '2.9T',
    revenue: '394.3B',
    employees: '164,000',
    founded: '1976',
    headquarters: 'Cupertino, CA',
  ),
];

// Simplified mock profiles for demonstration
final mockUserProfiles = [
  UserProfile(
    id: 'user-anna',
    name: 'Anna Schmidt',
    avatar: 'https://images.unsplash.com/photo-1659353218851-abe20addb330?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxidXNpbmVzcyUyMHByb2Zlc3Npb25hbCUyMHdvbWFuJTIwaGVhZHNob3R8ZW58MXx8fHwxNzU3MDY2MDEyfDA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral',
    bio: 'Tech-Investorin mit Fokus auf nachhaltige Technologien',
    joinedDate: DateTime(2023, 5, 15).toIso8601String(),
    isPublic: true,
    watchlist: [
      WatchlistEntry(
        stock: mockTrendingStocks[0],
        entryPrice: 235.20,
        entryDate: DateTime.now().subtract(const Duration(days: 14)).toIso8601String(),
        currentReturn: 13.30,
        currentReturnPercent: 5.65,
      ),
    ],
    activities: [],
    stats: UserStats(
      totalStocks: 3,
      avgReturn: 3.15,
      bestPerformer: 'MSFT',
      followers: 127,
      following: 45,
    ),
  ),
  // More profiles would go here...
];

final mockFriendsActivity = [
  FriendActivity(
    id: 'activity-1',
    friendName: 'Anna Schmidt',
    friendAvatar: 'https://images.unsplash.com/photo-1659353218851-abe20addb330?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxidXNpbmVzcyUyMHByb2Zlc3Npb25hbCUyMHdvbWFuJTIwaGVhZHNob3R8ZW58MXx8fHwxNzU3MDY2MDEyfDA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral',
    stock: mockTrendingStocks[0],
    action: 'liked',
    timestamp: DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
  ),
];