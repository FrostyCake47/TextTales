import 'package:texttales/models/player.dart';

class LobbyStatus{
  final String id;
  late List<Player> currentPlayers;

  LobbyStatus(this.id);
}