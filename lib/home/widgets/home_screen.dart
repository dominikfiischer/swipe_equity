import 'package:flutter/material.dart';
import '../../domain/models/ticker/ticker.dart';
import '../../data/stock.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // The state class is correctly named _HomeScreenState (private)
  _HomeScreenState createState() => _HomeScreenState();
}

// The entire implementation is now in the private state class
class _HomeScreenState extends State<HomeScreen> {
  final api = TickerLoader();
  late Future<List<Stock>> futureStocks;
  int _selectedIndex = 0;

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

  // FIX: Moved this helper method INSIDE the private state class (_HomeScreenState)
  Widget _buildStockDataRow(String label, dynamic value, [String unit = '']) {
    final displayValue = value is double
        ? value.toStringAsFixed(2)
        : value is int
        ? value.toString()
        : "N/A";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // The Label takes only the space it needs
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),

          // 🛠️ FIX: Wrapped the value Text widget in Expanded.
          // This forces it to fit within the remaining horizontal space.
          Expanded(
            child: Text(
              '$displayValue $unit',
              textAlign: TextAlign.right, // Optional: keeps the text aligned right
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Discover'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 1,
              color: Colors.grey,
            ),
        ),
      ),
      body: FutureBuilder<List<Stock>>(
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

              return Center(
                child: Card(
                  margin: const EdgeInsets.all(24),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          stock.symbol,
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildStockDataRow("Current Price (Close)", stock.price, "USD"),
                        _buildStockDataRow("Open", stock.open, "USD"),
                        _buildStockDataRow("High", stock.high, "USD"),
                        _buildStockDataRow("Low", stock.low, "USD"),
                        _buildStockDataRow("Volume", stock.volume),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Portfolio'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}