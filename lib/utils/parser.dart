class DataParser {
  static List<String> parseStringList(List dynamicList) {
    List<String> list = [];
    if (dynamicList == null) return <String>[];
    for (var c in dynamicList) {
      list.add(c.toString());
    }
    return list;
  }
}
