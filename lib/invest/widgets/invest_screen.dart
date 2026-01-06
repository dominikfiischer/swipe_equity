import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InvestScreen extends StatefulWidget {
  const InvestScreen({super.key});

  @override
  State<InvestScreen> createState() => _InvestScreenState();
}

class _InvestScreenState extends State<InvestScreen> {
  // 1. The Master List of Brokers
  final List<Map<String, dynamic>> allBrokers = [
    {
      'name': 'Trade Republic',
      'logoUrl': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Trade_Republic_logo_2021.svg/512px-Trade_Republic_logo_2021.svg.png',
      'url': 'https://traderepublic.com',
    },
    {
      'name': 'Scalable Capital',
      'logoUrl': 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Scalable_Capital_Logo.svg/512px-Scalable_Capital_Logo.svg.png',
      'url': 'https://scalable.capital',
    },
    {
      'name': 'flatex',
      'logoUrl': 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Flatex_logo.svg/512px-Flatex_logo.svg.png',
      'url': 'https://www.flatex.de',
    },
    {
      'name': 'ING',
      'logoUrl': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/ING_logo.png/512px-ING_logo.png',
      'url': 'https://www.ing.de',
    },
    {
      'name': 'justTRADE',
      'logoUrl': 'https://static.justtrade.com/assets/images/logo.png',
      'url': 'https://www.justtrade.com',
    },
    {
      'name': 'Smartbroker+',
      'logoUrl': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Smartbroker_Logo_%282022%29.svg/512px-Smartbroker_Logo_%282022%29.svg.png',
      'url': 'https://smartbrokerplus.de',
    },
  ];

  // 2. This list will hold the brokers that match our search
  List<Map<String, dynamic>> filteredBrokers = [];

  @override
  void initState() {
    super.initState();
    // Initially, show all brokers
    filteredBrokers = allBrokers;
  }

  // 3. Search Logic: Filter the list as you type
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = allBrokers;
    } else {
      results = allBrokers
          .where((broker) =>
          broker["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredBrokers = results;
    });
  }

  // 4. Function to open the website
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Broker',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // 🔍 Search Bar
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: const Color(0xFF121212),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white10),
              ),
              child: TextField(
                onChanged: (value) => _runFilter(value), // 🚀 Triggers filtering
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search brokers...',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                  prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 📜 Broker List
            Expanded(
              child: filteredBrokers.isNotEmpty
                  ? ListView.builder(
                itemCount: filteredBrokers.length,
                itemBuilder: (context, index) {
                  return _buildBrokerCard(filteredBrokers[index]);
                },
              )
                  : const Center(
                child: Text(
                  'No brokers found',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrokerCard(Map<String, dynamic> broker) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // 🚀 Logo with Error Handling
          Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(
              broker['logoUrl'],
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.business, color: Colors.grey); // Placeholder
              },
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Text(
              broker['name'],
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),

          // 🚀 Clickable "Select" Action
          GestureDetector(
            onTap: () => _launchURL(broker['url']),
            child: const Row(
              children: [
                Icon(Icons.open_in_new, color: Colors.white70, size: 16),
                SizedBox(width: 6),
                Text(
                  'Select',
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}