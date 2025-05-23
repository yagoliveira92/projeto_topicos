import 'package:firebase_ai/firebase_ai.dart';

class GeminiChatService {
  GenerativeModel initChat() {
    final geminiResponse = FirebaseAI.googleAI().generativeModel(model: 'gemini-2.0-flash',
      tools: [
        Tool.functionDeclarations([
          optimizeSqlQueryFunction,
        ]),
      ],
      systemInstruction: Content.text('''
    With a deep understanding of SQL query optimization in PostgreSQL, you
    translate performance insights into actionable recommendations, ensuring queries
    are fast and efficient
    '''),
    );
    return geminiResponse;
  }

  FunctionDeclaration get optimizeSqlQueryFunction => FunctionDeclaration(
      'optimizeSQLQuery', // A descriptive name for your function
      'Optimizes a given SQL query provided by the user.', // A clear description of what the function does
      parameters: {
        'sqlQuery': Schema.string(description: 'The SQL query to be optimized.'),
        'suggestions': Schema.string(description: 'Suggestions for optimizing the SQL query.'),
        'explanation': Schema.string(description: 'Explanation of the SQL query and its optimization.'),
      }
  );
}