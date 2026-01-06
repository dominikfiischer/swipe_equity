import 'package:flutter/material.dart';
import '../../data/stock.dart'; // Ensure the path to your Stock model is correct

class WatchlistScreen extends StatelessWidget {
  // 🚀 Require the list of items in the constructor
  final List<Stock> items;

  const WatchlistScreen({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Watchlist'),
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFF424242)),
        ),
      ),
      // 🚀 Use a conditional check to show either the list or the empty state
      body: items.isEmpty ? _buildEmptyState() : _buildWatchlist(),
    );
  }

  // 📜 Widget for the actual list of stocks
  Widget _buildWatchlist() {
    return ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        final stock = items[index];
        return Card(
          color: const Color(0xFF1A1A1A),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: Colors.white10,
              child: Text(
                  stock.ticker[0],
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
              ),
            ),
            title: Text(
              stock.name,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              stock.ticker,
              style: const TextStyle(color: Colors.greenAccent),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ),
        );
      },
    );
  }

  // 📭 Widget for the empty state (your original design)
  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star_border, color: Colors.grey, size: 64),
          SizedBox(height: 16),
          Text(
            'Your watchlist is empty',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            'Swipe right on an asset to add it here.',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}