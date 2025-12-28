import 'package:flutter/material.dart';
import '../../domain/models/ticker/ticker.dart';
import '../../data/stock.dart';
import '../../invest/widgets/invest_screen.dart';
import '../../search/widgets/search_screen.dart';
import '../../watchlist/widgets/watchlist_screen.dart';
import '../../profile/widgets/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final api = TickerLoader();
  late Future<List<Stock>> futureStocks;
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home, 'label': 'Discover'},
    {'icon': Icons.search, 'label': 'Search'},
    {'icon': Icons.star_border, 'label': 'Watchlists'},
    {'icon': Icons.person_outline, 'label': 'Profile'},
  ];

  @override
  void initState() {
    super.initState();
    futureStocks = api.fetchStocks();
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToInvestScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InvestScreen()),
    );
  }

  // 🛠️ Helper method to build the main swiping content
  // lib/home/widgets/home_screen.dart

  Widget _buildDiscoverContent() {
    return Stack(
      children: [
        FutureBuilder<List<Stock>>(
          future: futureStocks,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final stocks = snapshot.data!;

            return PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stocks.length,
              itemBuilder: (context, index) {
                final stock = stocks[index];

                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Added space so content starts below the Invest button
                      const SizedBox(height: 70),

                      const Text(
                        'Key Stats',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // List Items using the helper method
                      _buildListInfo('Market capitalization', stock.marketCap),
                      _buildListInfo('Dividend yield', stock.dividendYield),
                      _buildListInfo('Price to earnings Ratio', stock.peRatio),
                      _buildListInfo('Average Volume', stock.averageVolume),
                      _buildListInfo('Founded', stock.founded),
                      _buildListInfo('Employees', stock.employees),
                      _buildListInfo('CEO', stock.ceo),

                      // Website Section (Custom Color)
                      const Text(
                        'Website',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stock.website ?? 'N/A', // Null safety fix
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // About Section
                      const Text(
                        'About',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stock.about ?? 'No description available.', // Null safety fix
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Extra padding at the bottom to ensure scrolling
                      // clears the BottomNavigationBar
                      const SizedBox(height: 120),
                    ],
                  ),
                );
              },
            );
          },
        ),
        // Layers the Invest button on top of the scrolling list
        _buildInvestButton(context),
      ],
    );
  }

// 🛠️ Updated Helper Method to accept Nullable Strings
  Widget _buildListInfo(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            value ?? 'N/A', // Null safety fallback
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvestButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 16.0),
      child: Align(
        alignment: Alignment.topRight,
        child: SizedBox(
          height: 40,
          child: ElevatedButton.icon(
            onPressed: () => _navigateToInvestScreen(context),
            icon: const Icon(Icons.trending_up, color: Colors.black, size: 20),
            label: const Text('Invest', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStockDataRow(String label, dynamic value, [String unit = '']) {
    final displayValue = value is double ? value.toStringAsFixed(2) : value?.toString() ?? "N/A";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          Expanded(child: Text('$displayValue $unit', textAlign: TextAlign.right, style: const TextStyle(fontSize: 18))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🛠️ Determine which screen to show based on _selectedIndex
    Widget currentBody;
    bool showAppBar = true;

    switch (_selectedIndex) {
      case 1:
        currentBody = const SearchScreen();
        showAppBar = false;
        break;
      case 2:
        currentBody = const WatchlistScreen();
        showAppBar = false;
        break;
      case 3:
        currentBody = const ProfileScreen();
        showAppBar = false; // Profile has its own AppBar
        break;
      default:
        currentBody = _buildDiscoverContent();
        showAppBar = true;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: showAppBar
          ? AppBar(
        title: const Text('Discover'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFF424242)),
        ),
      )
          : null,
      body: currentBody,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 1.0, color: const Color(0xFF424242)),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: BottomNavigationBar(
              backgroundColor: Colors.black,
              currentIndex: _selectedIndex,
              onTap: _onNavTapped,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              items: _navItems.asMap().entries.map((entry) {
                int index = entry.key;
                bool isSelected = index == _selectedIndex;
                return BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(entry.value['icon'], color: isSelected ? Colors.black : Colors.white),
                  ),
                  label: entry.value['label'],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}