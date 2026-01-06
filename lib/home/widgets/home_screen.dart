import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

// Import your models and other screens
import '../../data/stock.dart';
import '../../card/widgets/tinder_card.dart';
import '../../invest/widgets/invest_screen.dart';
import '../../search/widgets/search_screen.dart';
import '../../watchlist/widgets/watchlist_screen.dart';
import '../../profile/widgets/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late Future<List<Stock>> futureStocks;

  // 🚀 Watchlist storage
  List<Stock> watchlist = [];

  @override
  void initState() {
    super.initState();
    futureStocks = _loadStocks();
  }

  Future<List<Stock>> _loadStocks() async {
    final String response = await rootBundle.loadString('assets/ticker.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Stock.fromJson(json)).toList();
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentBody;

    switch (_selectedIndex) {
      case 1:
        currentBody = const SearchScreen();
        break;
      case 2:
      // 🚀 Pass the current watchlist to the WatchlistScreen
        currentBody = WatchlistScreen(items: watchlist);
        break;
      case 3:
        currentBody = const ProfileScreen();
        break;
      default:
        currentBody = FutureBuilder<List<Stock>>(
          future: futureStocks,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return const Center(child: Text("Error loading data", style: TextStyle(color: Colors.white)));
            }

            final stocks = snapshot.data!;
            int safeDisplayCount = stocks.length < 3 ? stocks.length : 3;

            return Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: 550,
                    child: CardSwiper(
                      cardsCount: stocks.length,
                      numberOfCardsDisplayed: safeDisplayCount,
                      backCardOffset: const Offset(0, 40),
                      padding: const EdgeInsets.symmetric(horizontal: 20),

                      // 🚀 Updated for version 7.2.0
                      allowedSwipeDirection: const AllowedSwipeDirection.only(
                        left: true,
                        right: true,
                      ),

                      // 🚀 Swipe Logic for Watchlist
                      onSwipe: (previousIndex, currentIndex, direction) {
                        if (direction == CardSwiperDirection.right) {
                          final swipedStock = stocks[previousIndex];
                          setState(() {
                            if (!watchlist.contains(swipedStock)) {
                              watchlist.add(swipedStock);
                            }
                          });
                        }
                        return true; // Return true to confirm the swipe
                      },

                      cardBuilder: (context, index, h, v) {
                        return TinderCard(stock: stocks[index]);
                      },
                    ),
                  ),
                ),

                // Floating Invest Button
                Positioned(
                  top: 0,
                  right: 20,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const InvestScreen()),
                      );
                    },
                    icon: const Icon(Icons.trending_up, color: Colors.black, size: 20),
                    label: const Text('Invest', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
              ],
            );
          },
        );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _selectedIndex == 0
          ? AppBar(
        title: const Text('Discover', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      )
          : null,
      body: currentBody,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.star_border), label: 'Watchlist'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}