import 'package:flutter/material.dart';
import '../../data/stock.dart'; // Ensure this path is correct

class TinderCard extends StatelessWidget {
  final Stock stock;

  const TinderCard({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E), // Professional dark gray
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Name and Ticker
          Text(
            stock.name,
            style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(
            stock.ticker,
            style: const TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 40),

          // Key Info Rows
          _buildInfoRow("Market Cap", stock.marketCap),
          _buildInfoRow("Div. Yield", stock.dividendYield),
          _buildInfoRow("P/E Ratio", stock.peRatio),
          _buildInfoRow("CEO", stock.ceo),

          const Spacer(),

          // About Section
          const Text("About", style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 8),
          Text(
            stock.about ?? "No description available.",
            style: const TextStyle(color: Colors.white70, fontSize: 15),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Helper method to keep the UI clean
  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 16)),
          Text(value ?? "N/A", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}