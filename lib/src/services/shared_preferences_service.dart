import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _sqlFileContentKey = 'sql_file_content';

  Future<void> saveSqlFileContent(String content) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sqlFileContentKey, content);
  }

  Future<String?> getSqlFileContent() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_sqlFileContentKey);
  }
}
