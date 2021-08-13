import 'db_util.dart';

class PostgresHelper {
  static Future<int> insert(String tableName, Map<String, dynamic> map) async {
    final rawBuffer = StringBuffer();
    for (var i = 0; i < map.entries.length; i++) {
      rawBuffer.write('@${map.entries.toList()[i].key}');
      if (i != (map.entries.length - 1)) {
        rawBuffer.write(',');
      }
    }

    return await DB.connection.execute(
      'insert into $tableName'
      ' values(${rawBuffer.toString()})',
      substitutionValues: parseMap(map),
    );
  }

  static Map<String, dynamic> parseMap(Map<String, dynamic> map) {
    for (var item in map.entries) {
      if (item.value is List) {
        map[item.key] = '{' + (item.value as List).join(',') + '}';
      }
    }
    return map;
  }
}
