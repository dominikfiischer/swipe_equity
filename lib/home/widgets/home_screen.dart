import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart'; // Correct import
import '../../card/widgets/tinder_card.dart'; // Match your file path

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Data for our cards
  final List<Color> cardColors = [
    Colors.deepOrange,
    Colors.blue,
    Colors.green,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          height: 500, // Fixed height for the swiper area
          child: CardSwiper(
            cardsCount: cardColors.length, // Parameter for version 2.1.0
            numberOfCardsDisplayed: 3, // Shows the cards underneath
            backCardOffset: const Offset(0, 40), // Spacing for the stack effect
            cardBuilder: (context, index, horizontalThreshold, verticalThreshold) {
              return TinderCard(color: cardColors[index]);
            },
          ),
        ),
      ),
    );
  }
}