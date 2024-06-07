import 'package:texttales/models/player.dart';

class Page{
  final String gameId;
  final int storyId;
  final int pageId;
  final String content;
  final Player author;

  Page(this.gameId, this.storyId, this.pageId, this.content, this.author);
}

class Story{
  final String gameId;
  final int storyId;
  late String title;
  late List<Page> pages;

  Story(this.gameId, this.storyId);
}