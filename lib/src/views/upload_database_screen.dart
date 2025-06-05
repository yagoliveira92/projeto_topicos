import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:projeto_topicos/src/commands/upload_command.dart';
import 'package:projeto_topicos/src/viewmodels/upload_view_model.dart';
import 'package:projeto_topicos/src/views/drop_zone_widget.dart';
import 'package:projeto_topicos/src/views/input_screen.dart';
import 'package:provider/provider.dart';

class UploadDatabaseScreen extends StatefulWidget {
  const UploadDatabaseScreen({super.key});

  @override
  State<UploadDatabaseScreen> createState() => _UploadDatabaseScreenState();
}

class _UploadDatabaseScreenState extends State<UploadDatabaseScreen> {
  bool highlighted = false;
  String message = '';
  @override
  Widget build(BuildContext context) {
    return Consumer<UploadViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.shouldNavigateToNextScreen) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const InputScreen()),
            );
          });
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Análise de SQL'),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Este é um aplicativo de Análise de SQL através de IA",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "Envie seu arquivo .sql contendo a estrutura do seu banco de dados"
                    " para que possa validar as queries e trazer sugestões de otimizações",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Image.asset(
                    'assets/logo_upload.png',
                    width: 150,
                    height: 150,
                  ),
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: highlighted ? Colors.blue : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color:
                            highlighted ? Colors.grey[200] : Colors.transparent,
                      ),

                      child: Stack(
                        children: [
                          DropZoneWidget(
                            onChangedStatus: (status) {
                              setState(() {
                                highlighted = status;
                                message =
                                    highlighted
                                        ? 'Solte o arquivo .sql aqui'
                                        : '';
                              });
                            },
                            message: message,
                            uploadBytes: (fileBytes, fileName) {
                              viewModel.saveDragFile(fileBytes, fileName);
                            },
                          ),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.upload),
                                SizedBox(width: 8),
                                Text('Enviar arquivo .sql'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed:
                        viewModel.isLoading
                            ? null
                            : () => viewModel.execute(PickAndSaveFileCommand()),
                    child:
                        viewModel.isLoading
                            ? const CircularProgressIndicator()
                            : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.upload),
                                SizedBox(width: 8),
                                Text('Enviar arquivo .sql'),
                              ],
                            ),
                  ),
                  if (viewModel.errorMessage != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      viewModel.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                  //if (viewModel.fileName != null) {},
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
