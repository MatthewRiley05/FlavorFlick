import 'package:flavor_flick/widgets/card_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  final CardSwiperController controller = CardSwiperController();

  // Example list of candidates; replace with your actual data model
  final List<String> candidates = [
    'Candidate 1',
    'Candidate 2',
    'Candidate 3',
    'Candidate 4',
    'Candidate 5',
  ];

  final cards = [
    'Candidate 1',
    'Candidate 2',
    'Candidate 3',
    'Candidate 4',
    'Candidate 5',
  ].map((name) => CardContainer()).toList();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: SafeArea(
          child: Center(
            child: CardSwiper(
              cardBuilder:
                  (
                    context,
                    index,
                    horizontalThresholdPercentage,
                    verticalThresholdPercentage,
                  ) => cards[index],
              cardsCount: cards.length,
            ),
          ),
        ),
      ),
    );
  }
}
