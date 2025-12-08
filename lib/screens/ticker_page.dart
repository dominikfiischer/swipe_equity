import 'package:flutter/material.dart';
import 'marketstack_api.dart';
import 'stock.dart';

class TickerPage extends StatefulWidget {
  const TickerPage({super.key}); // added const constructor

  @override
  _TickerPageState createState() => _TickerPageState();
}

class _TickerPageState extends State<TickerPage> {
  final api = MarketstackAPI();
  late Future<List<Stock>> futureStocks;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    futureStocks = api.fetchNasdaqStocks();
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Add navigation actions if needed based on index
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticker'),
        backgroundColor: Colors.black,
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
                        const SizedBox(height: 16),
                        Text(
                          "${stock.price.toStringAsFixed(2)} USD",
                          style: const TextStyle(fontSize: 28),
                        ),
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
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        type: BottomNavigationBarType.fixed,
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
