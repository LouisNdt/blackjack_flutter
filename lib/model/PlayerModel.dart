import 'package:blackjack/model/CardModel.dart';
import 'package:blackjack/model/DeckModel.dart';
import 'package:flutter/animation.dart';

class PlayerModel {
  List<CardModel> playerCards = [];
  int points = 0;

  void drawCardForPlayer(DeckModel deck, AnimationController animationController) {
    CardModel cardModel = deck.drawCard();
    playerCards.add(cardModel);
    points += cardModel.points;
    animationController.reset();
    animationController.forward();
  }
}