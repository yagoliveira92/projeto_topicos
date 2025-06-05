import 'dart:convert';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:http/http.dart' as http;

class SQLService {
  Future<String> sendSqlFirebase(
    String sqlQuery,
    ChatSession session,
    String databaseSchema,
  ) async {
    final prompt = Content.multi([
      TextPart('''
      Analise a consulta SQL do PostgreSQL fornecida e exiba recomendações de otimização baseada no database schema conhecido. sugira quaisquer otimizações ou
      melhorias potenciais que possam ser feitas para aprimorar o desempenho e a eficiência da consulta.
            '''),
      //TextPart('Este é o Diagrama de Banco de Dados: $databaseSchema'),
      TextPart('Esta é a Query SQL: $sqlQuery'),
    ]);
    final response = await session.sendMessage(prompt);
    if (response.candidates.isNotEmpty) {
      return response.text ?? '';
    }
    throw Exception('No function calls found in the response.');
  }
}
