import 'package:flutter/material.dart';
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
      try {
        final response = await _sqlService.sendSQL(sql);
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
