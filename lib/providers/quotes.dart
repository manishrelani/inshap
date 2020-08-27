import 'package:flutter/foundation.dart' show ChangeNotifier, compute, debugPrint;
import 'package:inshape/data_models/quotes.dart';

class QuotesProvider with ChangeNotifier {
  Map<String, Quote> _quotes = Map();

  Future<void> pullFromJSON(var quotesJSON) async {
    final quotesMap = await compute(Quote.fromJSONList, quotesJSON);
    _quotes = quotesMap;
    debugPrint("quotesMap length: ${quotesMap.length}");
    notifyListeners();
    return;
  }

  Map<String, Quote> get quotes => _quotes;

  set quotes(Map<String, Quote> value) {
    _quotes = value;
    notifyListeners();
  }
}
