import 'package:flutter/material.dart';
import 'package:projeto_topicos/src/viewmodels/sql_view_model.dart';
import 'package:provider/provider.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  @override
  Widget build(BuildContext context) {
    final sqlViewModel = context.watch<SQLViewModel>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              sqlViewModel.lastSubmittedSQL != null
                  ? "Último SQL enviado: ${sqlViewModel.lastSubmittedSQL}"
                  : "Conteúdo principal da tela",
            ),
            if (sqlViewModel.responseMessage != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  sqlViewModel.responseMessage!,
                  style: const TextStyle(color: Colors.green),
                ),
              ),
          ],
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: sqlViewModel.sqlController,
                decoration: const InputDecoration(
                  labelText: 'Escreva seu SQL',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => sqlViewModel.submitSQL(),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.send_rounded, color: Colors.blue),
              onPressed: sqlViewModel.submitSQL,
            ),
          ],
        ),
      ),
    );
  }
}
