import 'package:flutter/material.dart';

class FileContentScreen extends StatelessWidget {
  final String fileContent; // Conteúdo do arquivo a ser exibido
  final String? fileName; // Nome do arquivo opcional para exibir no AppBar

  const FileContentScreen({Key? key, required this.fileContent, this.fileName})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          fileName ?? 'Conteúdo do Arquivo',
        ), // Usa o nome do arquivo ou um título padrão
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          16.0,
        ), // Adiciona um pouco de espaçamento ao redor do texto
        child: SingleChildScrollView(
          // Permite rolagem se o conteúdo for muito grande
          child: SelectableText(
            fileContent,
            style: const TextStyle(
              fontSize: 16.0, // Tamanho de fonte padrão
              fontFamily:
                  'monospace', // Uma boa fonte para exibir código ou texto de arquivo
              height: 1.5, // Espaçamento entre linhas para melhor legibilidade
            ),
            textAlign: TextAlign.left, // Alinhamento do texto
            // Você pode adicionar mais customizações ao SelectableText se necessário:
            // showCursor: true,
            // cursorColor: Colors.blue,
            // cursorWidth: 2.0,
            // toolbarOptions: ToolbarOptions(copy: true, selectAll: true, cut: false, paste: false),
          ),
        ),
      ),
    );
  }
}
