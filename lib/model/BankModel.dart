import 'package:flutter/animation.dart';

import 'CardModel.dart';
import 'DeckModel.dart';

class BankModel {
  List<CardModel> bankCards = [];
  int points = 0;

  void drawCardForBank(DeckModel deck, bool isFaceUp, AnimationController animationController) {
    CardModel cardModel = deck.drawCard();
    cardModel.isFaceUp = isFaceUp;
    bankCards.add(cardModel);
    points += cardModel.points;
    animationController.reset();
    animationController.forward();
  }
}