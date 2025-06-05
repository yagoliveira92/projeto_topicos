// gemini_chat_service.dart

import 'package:firebase_ai/firebase_ai.dart';

class GeminiChatService {
  GenerativeModel initChat(String databaseSchema) {
    // É uma boa prática garantir que o schema não seja nulo ou completamente vazio,
    // embora a instrução de sistema abaixo tente lidar com um schema vazio.
    final String effectiveSchema =
        (databaseSchema.trim().isEmpty)
            ? "Nenhum esquema fornecido."
            : databaseSchema;
    // final systemInstructionText = '''
    //     Com um profundo conhecimento da otimização de consultas SQL no PostgreSQL, você
    // traduz insights de desempenho em recomendações práticas, garantindo que as consultas
    // sejam rápidas e eficientes
    // ''';
    final systemInstructionText = '''
        Você é um especialista em SQL para PostgreSQL, com profundo conhecimento em otimização de consultas e análise de esquemas de banco de dados. Sua principal tarefa é traduzir insights de desempenho em recomendações práticas, garantindo que as consultas sejam rápidas, eficientes e corretas, considerando o esquema fornecido.

        **Instruções Críticas:**

        1. **Análise Baseada em Esquema:** TODA análise, otimização ou validação de consultas SQL DEVE ser estritamente baseada no esquema de banco de dados fornecido abaixo. Não presuma a existência de tabelas ou colunas que não estejam explicitamente listadas no esquema.

        2. **Validação de Entidades:** Ao receber uma consulta SQL, SEMPRE verifique se todas as tabelas e colunas referenciadas na consulta existem no esquema fornecido.
        3. **Otimização Eficaz:** Se a consulta for válida em relação ao esquema, forneça recomendações de otimização que resultem em consultas mais rápidas e eficientes. Considere o uso de índices, a reescrita de JOINs, cláusulas WHERE mais eficientes, etc.
        4. **Clareza:** Explique suas recomendações de forma clara e concisa.
        5. **Foco no PostgreSQL:** Suas sugestões devem ser otimizadas para a sintaxe e a funcionalidade do PostgreSQL.

        **Esquema de Banco de Dados para Referência:**
        --- ESQUEMA DO BANCO DE DADOS ---
        $effectiveSchema
        --- FIM DO ESQUEMA ---

        Lembre-se: a precisão do esquema é crítica. Se o esquema fornecido estiver vazio ou "Nenhum esquema fornecido", você deve informar ao usuário que não é possível validar ou otimizar consultas de forma eficaz sem um esquema de banco de dados.
        ''';
    final geminiModel = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-2.0-flash',
      systemInstruction: Content.text(systemInstructionText),
      // safetySettings: ... // se necessário
    );
    return geminiModel;
  }
}
