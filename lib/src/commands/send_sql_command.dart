import 'package:firebase_ai/firebase_ai.dart';

import '../services/sql_service.dart';
import 'command.dart';

class SendSQLCommand implements Command<String> {
  final SQLService sqlService;
  final String sqlQuery;

  SendSQLCommand({required this.sqlService, required this.sqlQuery});

  @override
  Future<String> execute() async {
    return await sqlService.sendSQL(sqlQuery,);
  }
}

class SendSQLCommandFirebase implements Command<String> {
  final SQLService sqlService;
  final String sqlQuery;
  final ChatSession session;

  SendSQLCommandFirebase({required this.sqlService, required this.sqlQuery, required this.session});

  @override
  Future<String> execute() async {
    return await sqlService.sendSqlFirebase(sqlQuery, session);
  }
}
