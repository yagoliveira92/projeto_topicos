import 'dart:convert';
import 'package:firebase_ai/firebase_ai.dart';
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

  Future<String> sendSqlFirebase(String sqlQuery, ChatSession session) async {
    final prompt = Content.multi([
      TextPart(
        '''
      Analyze the provided PostgreSQL SQL query and provide a detailed explanation of 
      its purpose, including the tables involved, the relationships between them, 
      and the expected output. Additionally, suggest any potential optimizations or 
      improvements that could be made to enhance the query's performance and efficiency.
      ''',
      ),
      TextPart('This is the SQL query:  $sqlQuery'),
    ]);
    final response = await session.sendMessage(prompt);
    if (response.functionCalls.isNotEmpty) {
      for (final functionCall in response.functionCalls) {
        switch (functionCall.name) {
          case 'optimizeSQLQuery':
            final query =  functionCall.args['sqlQuery'] as String;
            final suggestions = functionCall.args['suggestions'] as String;
            final explanation = functionCall.args['explanation'] as String;
            return '''
            SQL Query: $query
            Suggestions: $suggestions
            Explanation: $explanation
            ''';
          default:
            print('Unknown function call: ${functionCall.name}');
        }
      }
    }
    throw Exception('No function calls found in the response.');
  }
}

