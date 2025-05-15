import '../services/sql_service.dart';
import 'command.dart';

class SendSQLCommand implements Command<String> {
  final SQLService sqlService;
  final String sqlQuery;

  SendSQLCommand({required this.sqlService, required this.sqlQuery});

  @override
  Future<String> execute() async {
    return await sqlService.sendSQL(sqlQuery);
  }
}
