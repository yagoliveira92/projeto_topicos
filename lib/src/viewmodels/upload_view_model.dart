import 'dart:convert' show utf8;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:projeto_topicos/src/commands/upload_command.dart';
import 'package:projeto_topicos/src/services/shared_preferences_service.dart';

class UploadViewModel extends ChangeNotifier {
  UploadViewModel();
  final SharedPreferencesService _prefsService = SharedPreferencesService();

  String? _fileName;
  String? get fileName => _fileName;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Propriedade para navegação (será observada pela View)
  bool _shouldNavigateToNextScreen = false;
  bool get shouldNavigateToNextScreen => _shouldNavigateToNextScreen;

  void resetNavigation() {
    _shouldNavigateToNextScreen = false;
    // Não é necessário notificar listeners aqui, a menos que
    // você queira reconstruir a UI por algum outro motivo.
  }

  Future<void> execute(UploadCommand command) async {
    _errorMessage = null; // Limpa erros anteriores
    if (command is PickAndSaveFileCommand) {
      await _pickAndSaveFile();
    } else if (command is GoToNextScreenCommand) {
      _navigateToNextScreen();
    }
    notifyListeners();
  }

  Future<void> _pickAndSaveFile() async {
    _isLoading = true;
    notifyListeners();

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['sql'],
      );

      if (result != null && result.files.isNotEmpty) {
        final fileBytes = result.files.first.bytes;
        final content = fileBytes != null ? utf8.decode(fileBytes) : '';
        _fileName = result.files.first.name;

        await _prefsService.saveSqlFileContent(content);
      } else {
        // O usuário cancelou o seletor de arquivos
        _fileName = null;
      }
    } catch (e) {
      _errorMessage = 'Erro ao selecionar ou salvar o arquivo: $e';
      _fileName = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _navigateToNextScreen() {
    if (_fileName != null) {
      _shouldNavigateToNextScreen = true;
      // Notificar os listeners fará com que a UI reaja à mudança de _shouldNavigateToNextScreen
      notifyListeners();
    } else {
      _errorMessage = "Nenhum arquivo selecionado para visualizar.";
      notifyListeners();
    }
  }

  // Método para carregar o conteúdo na próxima tela (pode ser movido para uma ViewModel separada para ShowSqlContentScreen)
  Future<String?> getSqlContent() {
    return _prefsService.getSqlFileContent();
  }
}
