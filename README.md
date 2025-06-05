# Análise de SQL por IA

Um aplicativo Flutter Web para otimizar consultas SQL e gerenciar esquemas de banco de dados com o poder da IA.

## 🎯 Objetivo do Projeto

Este projeto visa fornecer uma ferramenta intuitiva e poderosa para desenvolvedores, analistas de dados e administradores de banco de dados (DBAs) que buscam otimizar suas consultas SQL e garantir sua corretude em relação a um esquema de banco de dados específico. O principal problema que o aplicativo resolve é a dificuldade e o tempo consumido na análise manual e otimização de queries SQL, especialmente em esquemas complexos.

O público-alvo são profissionais que trabalham regularmente com bancos de dados relacionais (com foco inicial em PostgreSQL) e precisam de uma maneira eficiente para:
1.  **Validar consultas:** Verificar rapidamente se as tabelas e colunas referenciadas em uma query SQL existem no esquema de banco de dados atual, evitando erros em tempo de execução.
2.  **Otimizar o desempenho:** Obter sugestões inteligentes para reescrever consultas SQL de forma a torná-las mais rápidas e eficientes, melhorando a performance geral do banco de dados.
3.  **Compreender as otimizações:** Receber explicações claras sobre as melhorias propostas, facilitando o aprendizado e a aplicação de boas práticas.

As principais funcionalidades para alcançar este objetivo incluem:
*   **Upload e Gerenciamento de Esquema SQL:** Os usuários podem facilmente fazer upload de seu arquivo `.sql` contendo a Data Definition Language (DDL) do banco, que é então armazenado localmente (`shared_preferences`) para referência contínua.
*   **Análise e Otimização com IA:** Ao submeter uma consulta SQL, o aplicativo utiliza o poder do Google Gemini (através da API `firebase_ai` ou Google AI) para realizar uma análise contextualizada. A IA utiliza o esquema carregado para validar entidades (tabelas, colunas) e, em seguida, sugere otimizações específicas, como o uso de índices apropriados, reescrita de JOINs, ou simplificação de cláusulas.
*   **Visualização Clara:** O conteúdo do esquema SQL e as respostas da IA (queries otimizadas, explicações) são exibidos de forma clara e selecionável para fácil cópia e uso.
*   **Interface Interativa:** Uma interface de usuário construída com Flutter oferece uma experiência fluida, incluindo uma área de "arrastar e soltar" para o upload de arquivos de esquema, e um tema visual customizável.

## ✨ Funcionalidades Principais

*   **Upload de Esquema SQL:** Permite ao usuário fazer upload de um arquivo `.sql` contendo o esquema do banco de dados (DDL).
*   **Armazenamento de Esquema:** O esquema é salvo localmente para uso futuro (usando `shared_preferences`).
*   **Otimização de Consultas SQL:** Usuários podem inserir consultas SQL, e o aplicativo utiliza a IA do Google (Gemini via `firebase_ai`) para:
    *   Validar a consulta contra o esquema carregado.
    *   Sugerir otimizações.
    *   Explicar as melhorias propostas.
*   **Visualização de Conteúdo:** Exibe o conteúdo de arquivos (como o esquema SQL carregado) de forma selecionável.
*   **Interface Amigável:** Interface de usuário construída com Flutter, com tema customizável e feedback visual para interações (como arrastar e soltar arquivos).

## 🛠️ Tecnologias Utilizadas

*   **Flutter (SDK Version):** 3.32.2
*   **Dart (SDK Version):** 3.8.1
*   **Firebase AI / Google AI (Gemini):** Para a inteligência artificial de otimização e análise de SQL.
*   **Provider:** Para gerenciamento de estado.
*   **SharedPreferences:** Para armazenamento local de dados (esquema SQL).
*   **File Picker / Dropzone (flutter_dropzone):** Para seleção e upload de arquivos.
*   **Google Fonts:** Para tipografia customizada.

## 🚀 Como Executar o Projeto Localmente

### Pré-requisitos

1.  **Flutter SDK:** Certifique-se de ter o Flutter instalado e configurado corretamente. Veja [Instalação do Flutter](https://flutter.dev/docs/get-started/install).
2.  **IDE:** Android Studio (com plugin Flutter) ou Visual Studio Code (com extensão Flutter).
3.  **Emulador/Dispositivo:** Ter um navegador Web
4.  **Firebase (Se aplicável para `firebase_ai` diretamente):**
    *   Crie um projeto no [Firebase Console](https://console.firebase.google.com/).
    *   Adicione um aplicativo Flutter ao seu projeto Firebase (siga as instruções para Android e/ou iOS).
    *   Baixe o arquivo de configuração `google-services.json` e coloque-o na raiz do seu projeto.

### Passos para Execução

1. **Instale as Dependências:**

    ```bash
    flutter pub get
    ```
2. **Execute o Aplicativo:**
    ```bash
    flutter pub run
    ```
   Selecione o dispositivo/emulador desejado quando solicitado, ou use flags específicas:
    # Para executar na web
    ```bash
    flutter run -d chrome
    ```
## 🏗️ Build do Projeto

### Web 

Para gerar um build de release para a Web:
```bash
flutter build web 
```
Os arquivos de build estarão em `build/web/`. Você pode então hospedar esses arquivos em qualquer serviço de hospedagem web estática.

## ☁️ Deploy

### Web

1.  Gere os arquivos de build para a web como descrito na seção de Build.
2.  Faça o deploy da pasta `build/web` para um serviço de hospedagem como:
    *   Firebase Hosting
    *   Netlify
    *   GitHub Pages
    *   Vercel
    *   Seu próprio servidor web

**Exemplo com Firebase Hosting:**
1.  Instale o Firebase CLI: `npm install -g firebase-tools`
2.  Faça login: `firebase login`
3.  Inicialize o Firebase Hosting no seu projeto: `firebase init hosting` deixando a configuração default.
4.  Crie a pasta `public` na raiz do projeto e copie o conteúdo de `build/web` para dentro dela. 
5. Faça o deploy: `firebase deploy --only hosting`

## 📜 Licença

Distribuído sob a Licença MIT.
---

**Autor**
Desenvolvido por Yago Oliveira - yagoliveira92@gmail.com como parte da disciplina tópicos avançados
em engenharia de software