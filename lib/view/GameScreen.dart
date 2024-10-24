import 'package:blackjack/model/BankModel.dart';
import 'package:blackjack/model/CardModel.dart';
import 'package:blackjack/model/DeckModel.dart';
import 'package:blackjack/model/PlayerModel.dart';
import 'package:blackjack/view/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.title});

  final String title;

  @override
  State<GameScreen> createState() => _MyGameScreenState();
}

class _MyGameScreenState extends State<GameScreen> {

  DeckModel deckModel = new DeckModel();
  PlayerModel playerModel = new PlayerModel();
  BankModel bankModel = new BankModel();

  @override
  void initState() {
    super.initState();
    bankModel.drawCardForBank(deckModel, false);
    bankModel.drawCardForBank(deckModel, true);
    playerModel.drawCardForPlayer(deckModel);
    playerModel.drawCardForPlayer(deckModel);  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF006400), // Vert foncé
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/green_background.jpg'),
          fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Score de la banque
              dispBankPoints(bankModel),
              SizedBox( // Ou ConstrainedBox
                width: MediaQuery.of(context).size.width / 2,
                height: 150,
                child: Stack(
                  children: [...dispCardForBank(bankModel, context)],
                ),
              ),
              // Score du joueur
              dispPlayerPoints(playerModel),
              SizedBox( // Ou ConstrainedBox
                width: MediaQuery.of(context).size.width / 2, // Ajustez la largeur selon vos besoins
                height: 150, // Ajustez la hauteur selon vos besoins
                child: Stack(
                  children: [...dispCardForPlayer(playerModel, context)],
                ),
              ),
              // Boutons
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          playerModel.drawCardForPlayer(deckModel);
                          if (playerModel.points > 21) {
                            showDialog(context: context, builder: (BuildContext context) {
                              return showResult(playerModel, bankModel, context);
                            });
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      child:const Text('Tirer'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          revealBankCards(bankModel);
                          while(bankModel.points < 17) {
                            bankModel.drawCardForBank(deckModel, true);
                          }
                          showDialog(context: context, builder: (BuildContext context) {
                            return showResult(playerModel, bankModel, context);
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Rester'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

List<Widget> dispCardForPlayer(PlayerModel playerModel, BuildContext context) {
  List<CardModel> playerCard = playerModel.playerCards;List<Widget> cardWidgets = []; // Liste vide pour stocker les widgets

  for (var i = 0; i < playerCard.length; i++) {
    cardWidgets.add(
      Positioned(
        left: i * 30.0,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: Image.asset(playerCard[i].imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }

  return cardWidgets;
}

List<Widget> dispCardForBank(BankModel bankModel, BuildContext context) {
  List<CardModel> bankCards = bankModel.bankCards;List<Widget> cardWidgets = []; // Liste vide pour stocker les widgets

  for (var i = 0; i < bankCards.length; i++) {
    cardWidgets.add(
      Positioned(
        left: i * 30.0,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: Image.asset(bankCards[i].isFaceUp ? bankCards[i].imageUrl : 'assets/Cards/card back black.png'),
        ),
      ),
    );
  }

  return cardWidgets;
}

Text dispPlayerPoints(PlayerModel playerModel) {
  int points = 0;
  for(var card in playerModel.playerCards) {
    card.isFaceUp == true ? points+=card.points : points = points;
  }
  return Text(
    'Joueur : $points',
    style: GoogleFonts.vastShadow(
      color: Colors.white,
      fontSize: 40,
    )
  );
}

Text dispBankPoints(BankModel bankModel) {
  int visiblePoints = 0;
  for(var card in bankModel.bankCards) {
    card.isFaceUp == true ? visiblePoints += card.points : visiblePoints = visiblePoints;
  }
    return Text(
        'Banque : $visiblePoints',
        style: GoogleFonts.vastShadow(
          color: Colors.white,
          fontSize: 40,
        )
    );
}

revealBankCards(BankModel bankModel) {
  for (var card in bankModel.bankCards) {
    card.isFaceUp = true;
  }
}

AlertDialog showResult(PlayerModel playerModel, BankModel bankModel, BuildContext context) {
  String title = "";
  if(playerModel.points > 21) {
    title = "Perdu ! Vous avez dépassé 21";
  } else if (playerModel.points <=21 && bankModel.points <= 21) {
    if(playerModel.points > bankModel.points) {
      title = "Bravo ! Vous avez battu la banque";
    } else if (playerModel.points < bankModel.points) {
      title = "Perdu ! La banque vous a battu";
    } else {
      title = "Egalité";
    }
  } else if (playerModel.points<=21 && bankModel.points > 21) {
    title = "Bravo ! Vous avez battu la banque";
  }

  return AlertDialog(
    title: Text(title),
    content: const Text('Rejouer ?'),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(title: title)), // Remplacer par la même page
          );
        },
        child: const Text('Non'),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          // Code pour effectuer l'action de confirmation
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => GameScreen(title: title)), // Remplacer par la même page
            );
          },
        child: const Text('Oui'),
      ),
    ],
  );
}

// Widget pour afficher une carte avec une image
class CardWidget extends StatelessWidget {
  final String cardImage;

  const CardWidget({super.key, required this.cardImage});

  @override
  Widget build(BuildContext context) {
    return Image.asset(cardImage);
  }
}
