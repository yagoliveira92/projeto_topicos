import 'package:firebase_ai/firebase_ai.dart';

import '../services/sql_service.dart';
import 'command.dart';

class SendSQLCommandFirebase implements Command<String> {
  final SQLService sqlService;
  final String sqlQuery;
  final ChatSession session;
  final String databaseSchema;

  SendSQLCommandFirebase({
    required this.sqlService,
    required this.sqlQuery,
    required this.session,
    required this.databaseSchema,
  });

  @override
  Future<String> execute() async {
    return await sqlService.sendSqlFirebase(sqlQuery, session, databaseSchema);
  }
}
