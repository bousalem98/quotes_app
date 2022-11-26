class Quote {
  late int id;
  late String author;
  late String title;
  Quote({required this.id, required this.author, required this.title});
  Quote.withoutId({required this.author,required this.title});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['author'] = author;
    return map;
  }

  // Extract a Note object from a Map object
  Quote.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.author = map['author'];
  }
}
