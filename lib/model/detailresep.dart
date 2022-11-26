import 'dart:convert';

DetailMasak masakFromJson(String str) => DetailMasak.fromJson(json.decode(str));

String masakToJson(DetailMasak data) => json.encode(data.toJson());

class DetailMasak {
  DetailMasak({
    required this.method,
    required this.status,
    required this.results,
  });

  String method;
  bool status;
  Results results;

  factory DetailMasak.fromJson(Map<String, dynamic> json) => DetailMasak(
        method: json["method"],
        status: json["status"],
        results: Results.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "method": method,
        "status": status,
        "results": results.toJson(),
      };
}

class Results {
  Results({
    required this.title,
    required this.thumb,
    required this.servings,
    required this.times,
    required this.difficulty,
    required this.author,
    required this.desc,
    required this.needItem,
    required this.ingredient,
    required this.step,
  });

  String title;
  dynamic thumb;
  String servings;
  String times;
  String difficulty;
  Author author;
  String desc;
  List<NeedItem> needItem;
  List<String> ingredient;
  List<String> step;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        title: json["title"],
        thumb: json["thumb"],
        servings: json["servings"],
        times: json["times"],
        difficulty: json["difficulty"],
        author: Author.fromJson(json["author"]),
        desc: json["desc"],
        needItem: List<NeedItem>.from(
            json["needItem"].map((x) => NeedItem.fromJson(x))),
        ingredient: List<String>.from(json["ingredient"].map((x) => x)),
        step: List<String>.from(json["step"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "thumb": thumb,
        "servings": servings,
        "times": times,
        "difficulty": difficulty,
        "author": author.toJson(),
        "desc": desc,
        "needItem": List<dynamic>.from(needItem.map((x) => x.toJson())),
        "ingredient": List<dynamic>.from(ingredient.map((x) => x)),
        "step": List<dynamic>.from(step.map((x) => x)),
      };
}

class Author {
  Author({
    required this.user,
    required this.datePublished,
  });

  String user;
  String datePublished;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        user: json["user"],
        datePublished: json["datePublished"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "datePublished": datePublished,
      };
}

class NeedItem {
  NeedItem({
    required this.itemName,
    required this.thumbItem,
  });

  String itemName;
  String thumbItem;

  factory NeedItem.fromJson(Map<String, dynamic> json) => NeedItem(
        itemName: json["item_name"],
        thumbItem: json["thumb_item"],
      );

  Map<String, dynamic> toJson() => {
        "item_name": itemName,
        "thumb_item": thumbItem,
      };
}
