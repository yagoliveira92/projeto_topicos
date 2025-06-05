import 'package:flutter/material.dart';
import 'package:projeto_topicos/src/viewmodels/sql_view_model.dart';
import 'package:projeto_topicos/src/views/file_content_screen.dart';
import 'package:provider/provider.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SQLViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isInitializing) {
          return Scaffold(
            appBar: AppBar(title: const Text('SQL Chat')),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Inicializando o chat e carregando esquema..."),
                ],
              ),
            ),
          );
        }
        if (viewModel.initializationError != null) {
          return Scaffold(
            appBar: AppBar(title: const Text('SQL Chat')),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Erro na inicialização: ${viewModel.initializationError}\nPor favor, verifique se você fez o upload do arquivo .sql.",
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }
        // UI principal quando inicializado
        return Scaffold(
          appBar: AppBar(title: const Text('SQL Chat - Pronto')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: viewModel.sqlController,
                  decoration: const InputDecoration(
                    labelText: 'Digite sua query SQL aqui',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => viewModel.submitSQL(),
                      child: const Text('Enviar para Otimização'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final fileContent = await viewModel.getSqlContent();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => FileContentScreen(
                                  fileContent: fileContent ?? '',
                                ),
                          ),
                        );
                      },
                      child: const Text('Ver Conteúdo'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (viewModel.responseMessage != null)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(viewModel.responseMessage!),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
