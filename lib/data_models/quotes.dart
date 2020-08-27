
class Quote {
  String id;
  String text;

  Quote({this.id, this.text});

  factory Quote.fromJSON(var map) {
    return Quote(
      id: map['_id'],
      text: map['text'],
    );
  }

  static Map<String, Quote> fromJSONList(var quotesJSON) {
    Map<String, Quote> quotesMap = Map();
//    final quotesJSON = json.decode(response)["payload"]["quotes"];
    for (var c in quotesJSON) {
      final q = Quote.fromJSON(c);
      quotesMap[q.id] = q;
    }
    return quotesMap;
  }
}
