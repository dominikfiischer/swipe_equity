import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../../card/widgets/tinder_card.dart';
import '../../invest/widgets/invest_screen.dart';
import '../../profile/widgets/profile_screen.dart';
import '../../search/widgets/search_screen.dart';
import '../../watchlist/widgets/watchlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Track which tab is active
  final List<Color> cardColors = [
    Colors.deepOrange,
    Colors.blue,
    Colors.green,
    Colors.purple,
  ];

  // Logic to handle tab tapping
  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine which content to show based on the selected index
    Widget currentBody;

    switch (_selectedIndex) {
      case 1:
        currentBody = const SearchScreen();
        break;
      case 2:
        currentBody = const WatchlistScreen();
        break;
      case 3:
        currentBody = const ProfileScreen();
        break;
      default:
      // 🚀 DISCOVER TAB WITH FLOATING INVEST BUTTON
        currentBody = Stack(
          children: [
            // Layer 1: The Card Swiper
            Center(
              child: SizedBox(
                height: 590,
                child: CardSwiper(
                  cardsCount: cardColors.length,
                  numberOfCardsDisplayed: 3,
                  backCardOffset: const Offset(0, 40),
                  cardBuilder: (context, index, horizontalThreshold, verticalThreshold) {
                    return TinderCard(color: cardColors[index]);
                  },
                ),
              ),
            ),

            // Layer 2: The Floating Invest Button
            Positioned(
              top: 5,
              right: 20,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InvestScreen()),
                  );
                },
                icon: const Icon(Icons.trending_up, color: Colors.black, size: 20),
                label: const Text(
                  'Invest',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      // AppBar only shows on the Discover (index 0) screen
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