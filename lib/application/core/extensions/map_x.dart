extension MapX on Map {
  Map copyMapAndAddOrReplaceElement(final dynamic key, final dynamic value) {
    final map = Map.of(this);
    map[key] = value;
    return map;
  }
}
