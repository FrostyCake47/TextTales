import 'package:texttales/models/player.dart';
import 'package:texttales/models/story.dart';

class GameData{
  final String id;
  late List<Story> stories;
  late List<Player> currentPlayers;

  GameData(this.id);
}