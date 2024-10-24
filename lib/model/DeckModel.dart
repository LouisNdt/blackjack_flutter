import 'dart:math';

import 'package:blackjack/model/CardModel.dart';

class DeckModel {
  List<CardModel> cards = [];
  DeckModel() {
    _buildDeck();
    _shuffleDeck();
  }


  void _buildDeck() {
    const List<String> values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king', 'ace'];
    const List<String> couleurs = ['clubs', 'diamonds', 'hearts', 'spades'];

    for (var couleur in couleurs) {
      for (var value in values) {
        cards.add(CardModel(value: value, couleur: couleur));
      }
    }
  }

  CardModel drawCard() {
    if (cards.isNotEmpty) {
      return cards.removeLast();
    } else {
      throw Exception('Le deck est vide!');
    }
  }

  void _shuffleDeck() {
    cards.shuffle(Random());
  }

}


