import 'package:flutter/material.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _sqlController = TextEditingController();

  void _submitSQL() {
    final sql = _sqlController.text.trim();
    if (sql.isNotEmpty) {
      print("SQL enviado: $sql");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("SQL enviado: $sql")));
      _sqlController.clear();
    }
  }

  @override
  void dispose() {
    _sqlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Conteúdo principal da tela")),
      bottomSheet: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _sqlController,
                decoration: const InputDecoration(
                  labelText: 'Escreva seu SQL',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _submitSQL(), // Envia ao pressionar "Enter"
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.send, color: Colors.blue),
              onPressed: _submitSQL,
            ),
          ],
        ),
      ),
    );
  }
}
