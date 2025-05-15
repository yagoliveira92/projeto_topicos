import 'dart:convert';
import 'package:http/http.dart' as http;

class SQLService {
  final String _baseUrl =
      'https://optimizing-sql-queries-with-gemini-llm-agen-6f3fa0d0.crewai.com/kickoff'; // Substitua pela URL da sua API
  final String _bearerToken = '6d1d7f71e1ea';

  Future<String> sendSQL(String sqlQuery) async {
    final url = Uri.parse(_baseUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_bearerToken',
        },
        body: jsonEncode({'query': sqlQuery}),
      );

      if (response.statusCode == 200) {
        // Sucesso
        return response.body;
      } else {
        // Erro da API
        throw Exception(
          'Erro ao enviar SQL: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      // Erro de conexão ou outro problema
      throw Exception('Erro ao conectar ao servidor: $e');
    }
  }
}
