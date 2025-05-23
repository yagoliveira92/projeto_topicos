import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:projeto_topicos/src/commands/send_sql_command.dart';
import 'package:projeto_topicos/src/services/gemini_chat_service.dart';
import 'package:projeto_topicos/src/services/sql_service.dart';

class SQLViewModel extends ChangeNotifier {
  SQLViewModel() {
    generativeModel = _chatService.initChat();
    chatSession = generativeModel.startChat();
  }
  final TextEditingController sqlController = TextEditingController();
  final SQLService _sqlService = SQLService();
  final GeminiChatService _chatService = GeminiChatService();
  late GenerativeModel generativeModel;
  late ChatSession chatSession;

  String? _lastSubmittedSQL;
  String? get lastSubmittedSQL => _lastSubmittedSQL;

  String? _responseMessage;
  String? get responseMessage => _responseMessage;

  Future<void> submitSQL() async {
    final sql = sqlController.text.trim();

    if (sql.isNotEmpty) {
      final command = SendSQLCommandFirebase(sqlService: _sqlService, sqlQuery: sql, session: chatSession,);
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
