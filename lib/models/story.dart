import 'package:texttales/models/player.dart';

class Page{
  final String content;
  final Player author;

  Page(this.content, this.author);
}

class Story{
  final String title;
  late List<Page> pages;

  Story(this.title);
}