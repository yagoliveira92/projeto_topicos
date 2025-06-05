import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:projeto_topicos/src/commands/send_sql_command.dart';
import 'package:projeto_topicos/src/services/gemini_chat_service.dart';
import 'package:projeto_topicos/src/services/shared_preferences_service.dart';
import 'package:projeto_topicos/src/services/sql_service.dart';

class SQLViewModel extends ChangeNotifier {
  SQLViewModel({required SharedPreferencesService prefsService})
    : _prefsService = prefsService {
    _initialize(); // Chamar o método de inicialização assíncrona
  }
  // Serviços
  final SQLService _sqlService = SQLService();
  final GeminiChatService _chatService = GeminiChatService();
  final SharedPreferencesService _prefsService;

  final TextEditingController sqlController = TextEditingController();
  late GenerativeModel? _generativeModel;
  late ChatSession? _chatSession;

  String? _lastSubmittedSQL;
  String? get lastSubmittedSQL => _lastSubmittedSQL;

  String? _responseMessage;
  String? get responseMessage => _responseMessage;

  bool _isInitializing = true; // Estado de inicialização
  bool get isInitializing => _isInitializing;

  String? _initializationError;
  String? get initializationError => _initializationError;

  bool _loading = false;
  bool get loading => _loading;

  // Método de inicialização assíncrona
  Future<void> _initialize() async {
    try {
      _isInitializing = true;
      _initializationError = null;
      notifyListeners(); // Notificar que a inicialização começou

      final String? databaseSchema = await _prefsService.getSqlFileContent();

      if (databaseSchema == null || databaseSchema.isEmpty) {
        // Tratar o caso onde o esquema não está disponível
        // Você pode querer definir um esquema padrão ou lançar um erro mais específico
        _initializationError =
            "Esquema do banco de dados não encontrado. Faça upload do arquivo .sql primeiro.";
        print(
          "SQLViewModel: Esquema do banco de dados não encontrado ou vazio.",
        );
        // Opcional: _generativeModel = _chatService.initChat(""); // Inicializar com esquema vazio se for permitido
      } else {
        // Passar o esquema para initChat
        _generativeModel = _chatService.initChat(databaseSchema);
        _chatSession =
            _generativeModel!.startChat(); // Agora _generativeModel não é nulo
      }
    } catch (e) {
      print("SQLViewModel: Erro durante a inicialização: $e");
      _initializationError = "Erro ao inicializar o chat: $e";
    } finally {
      _isInitializing = false;
      notifyListeners(); // Notificar que a inicialização terminou (com sucesso ou erro)
    }
  }

  Future<void> submitSQL() async {
    if (_isInitializing) {
      _responseMessage = 'Aguarde, o chat está sendo inicializado...';
      notifyListeners();
      return;
    }

    if (_chatSession == null) {
      _responseMessage =
          'Erro: Sessão de chat não inicializada. Verifique se o esquema do BD foi carregado.';
      notifyListeners();
      return;
    }

    final sql = sqlController.text.trim();

    if (sql.isNotEmpty) {
      _loading = true;
      notifyListeners();
      final String? databaseSchema = await _prefsService.getSqlFileContent();
      final command = SendSQLCommandFirebase(
        sqlService: _sqlService,
        sqlQuery: sql,
        databaseSchema: databaseSchema ?? '',
        session: _chatSession!,
      );
      try {
        final response = await command.execute();
        _responseMessage = response;
        _lastSubmittedSQL = sql;
        _loading = false;
        sqlController.clear();
      } catch (e) {
        _responseMessage = 'Erro: $e';
      }
      notifyListeners();
    }
  }

  Future<String?> getSqlContent() {
    return _prefsService.getSqlFileContent();
  }

  @override
  void dispose() {
    sqlController.dispose();
    super.dispose();
  }
}
