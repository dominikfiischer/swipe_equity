import 'package:flutter/material.dart';
import '../../data/stock.dart'; // Ensure this path correctly points to your stock model

class TinderCard extends StatelessWidget {
  final Stock stock;

  const TinderCard({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Padding inside the card so content doesn't touch the edges
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E), // Professional dark gray
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      // 🚀 SingleChildScrollView allows the user to scroll up/down
      // to read long "About" sections without swiping the card away.
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // Adds a premium feel when scrolling
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Name and Ticker
            Text(
              stock.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              stock.ticker,
              style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
              ),
            ),
            const Divider(color: Colors.white10, height: 40),

            const Text("Market Stats", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildInfoRow("Market Cap", stock.marketCap),
            _buildInfoRow("52-Week High", stock.high52),
            _buildInfoRow("52-Week Low", stock.low52),
            _buildInfoRow("P/E Ratio", stock.peRatio),
            _buildInfoRow("Profit Margin", stock.profitMargin),

            const SizedBox(height: 30),

            const Text("Company Info", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildInfoRow("Industry", stock.industry),
            _buildInfoRow("CEO", stock.ceo),

            const SizedBox(height: 30),

            // About Section
            const Text(
                "About",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2
                )
            ),
            const SizedBox(height: 10),
            Text(
              stock.about ?? "No description available.",
              style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5 // Improves readability of long text
              ),
            ),

            // Extra padding at the bottom so the last line isn't cramped
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper method to create the stat rows
  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 16)
          ),
          Text(
              value ?? "N/A",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              )
          ),
        ],
      ),
    );
  }
}