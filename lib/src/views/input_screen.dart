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
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
        //margin: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
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
              icon: Icon(Icons.send_rounded, color: Colors.blue),
              onPressed: _submitSQL,
            ),
          ],
        ),
      ),
    );
  }
}
