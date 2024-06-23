// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:texttales/models/player.dart';

class Page {
  final int storyId;
  final int pageId;
  final String content;
  final Player playerId;

  Page(
    this.storyId,
    this.pageId,
    this.content,
    this.playerId,
  );

  Page copyWith({
    int? storyId,
    int? pageId,
    String? content,
    Player? playerId,
  }) {
    return Page(
      storyId ?? this.storyId,
      pageId ?? this.pageId,
      content ?? this.content,
      playerId ?? this.playerId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'storyId': storyId,
      'pageId': pageId,
      'content': content,
      'playerId': playerId.toMap(),
    };
  }

  factory Page.fromMap(Map<String, dynamic> map) {
    return Page(
      map['storyId'] as int,
      map['pageId'] as int,
      map['content'] as String,
      Player.fromMap(map['playerId'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Page.fromJson(String source) => Page.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Page(storyId: $storyId, pageId: $pageId, content: $content, playerId: $playerId)';
  }

  @override
  bool operator ==(covariant Page other) {
    if (identical(this, other)) return true;
  
    return 
      other.storyId == storyId &&
      other.pageId == pageId &&
      other.content == content &&
      other.playerId == playerId;
  }

  @override
  int get hashCode {
    return storyId.hashCode ^
      pageId.hashCode ^
      content.hashCode ^
      playerId.hashCode;
  }
}


class Story {
  final String gameId;
  final int storyId;
  final String title;
  final List<Page> pages;

  Story(
    this.gameId,
    this.storyId,
    this.title,
    this.pages,
  );

  Story copyWith({
    String? gameId,
    int? storyId,
    String? title,
    List<Page>? pages,
  }) {
    return Story(
      gameId ?? this.gameId,
      storyId ?? this.storyId,
      title ?? this.title,
      pages ?? this.pages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gameId': gameId,
      'storyId': storyId,
      'title': title,
      'pages': pages.map((x) => x.toMap()).toList(),
    };
  }

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      map['gameId'] as String,
      map['storyId'] as int,
      map['title'] as String,
      List<Page>.from((map['pages'] as List<int>).map<Page>((x) => Page.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Story.fromJson(String source) => Story.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Story(gameId: $gameId, storyId: $storyId, title: $title, pages: $pages)';
  }

  @override
  bool operator ==(covariant Story other) {
    if (identical(this, other)) return true;
  
    return 
      other.gameId == gameId &&
      other.storyId == storyId &&
      other.title == title &&
      listEquals(other.pages, pages);
  }

  @override
  int get hashCode {
    return gameId.hashCode ^
      storyId.hashCode ^
      title.hashCode ^
      pages.hashCode;
  }
}
