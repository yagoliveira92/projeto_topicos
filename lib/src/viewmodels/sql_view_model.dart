import 'package:flutter/material.dart';
import 'package:projeto_topicos/src/commands/send_sql_command.dart';
import 'package:projeto_topicos/src/services/sql_service.dart';

class SQLViewModel extends ChangeNotifier {
  final TextEditingController sqlController = TextEditingController();
  final SQLService _sqlService = SQLService();

  String? _lastSubmittedSQL;
  String? get lastSubmittedSQL => _lastSubmittedSQL;

  String? _responseMessage;
  String? get responseMessage => _responseMessage;

  Future<void> submitSQL() async {
    final sql = sqlController.text.trim();
    if (sql.isNotEmpty) {
      final command = SendSQLCommand(sqlService: _sqlService, sqlQuery: sql);
      try {
        final response = await command.execute();
        _responseMessage = 'Resposta da API: $response';
        _lastSubmittedSQL = sql;
        sqlController.clear();
      } catch (e) {
        _responseMessage = 'Erro: $e';
      }
      notifyListeners();
    }
  }

  @override
  void dispose() {
    sqlController.dispose();
    super.dispose();
  }
}
