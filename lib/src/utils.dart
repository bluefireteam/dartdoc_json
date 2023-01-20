/// Cleans up the [map] by removing all key-value pairs where the value is null.
Map<String, dynamic> filterMap(Map<String, dynamic> map) {
  map.removeWhere((_, dynamic value) => value == null);
  return map;
}
