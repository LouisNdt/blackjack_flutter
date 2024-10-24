class CardModel {
  final String value;
  final String couleur;
  bool isFaceUp;
  String imageUrl;
  int get points {
    switch (value) {
      case 'ace':
        return 11; // ou 1 selon le contexte du jeu
      case 'king':
      case 'queen':
      case 'jack':
        return 10;
      default:
        return int.parse(value);
    }
  }

  CardModel({
    required this.value,
    required this.couleur,this.isFaceUp = true,
  }) : imageUrl = "assets/Cards/${value}_of_${couleur}.png"; // Interpolation de chaînes


}