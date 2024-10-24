import 'package:blackjack/model/CardModel.dart';
import 'package:blackjack/model/DeckModel.dart';

class PlayerModel {
  List<CardModel> playerCards = [];
  int points = 0;

  void drawCardForPlayer(DeckModel deck) {
    CardModel cardModel = deck.drawCard();
    playerCards.add(cardModel);
    points += cardModel.points;
  }
}