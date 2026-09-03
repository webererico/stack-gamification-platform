# Stack Up

Plataforma gamificada de autoavaliação de skills técnicas por squad.

Cada desenvolvedor se autoavalia (0-10) nas skills da sua stack. Isso vira
barras de XP, um nível geral (Iniciante → Especialista) e um radar de
habilidades — dando ao time e à liderança uma visão clara de quem sabe o quê,
para alocação em projetos e planos de crescimento.

## Stack técnica

- **Flutter** (Android, iOS, Web) com arquitetura feature-first / Clean
  Architecture, no mesmo padrão do MyCare: `data` / `domain` /
  `presentation` / `state_management` por feature.
- **Firebase Authentication** (e-mail/senha) para login.
- **Cloud Firestore** como banco de dados, com transparência total entre
  membros da mesma organização (qualquer usuário autenticado pode ler
  qualquer perfil/skill; só o dono pode escrever as próprias avaliações).
- `flutter_bloc` (Cubits) para estado, `get_it` para injeção de
  dependência, `go_router` para navegação, `fl_chart` para o radar de
  skills.

## Status do projeto Firebase

O app já está conectado a um projeto Firebase real (`stack-up-917a4`):

- ✅ `lib/firebase_options.dart` configurado (`flutterfire configure`)
- ✅ Firestore criado, com `firestore.rules` e `firestore.indexes.json`
  publicados
- ✅ Web publicado no Firebase Hosting: **https://stack-up-917a4.web.app**
- ⚠️ **Falta habilitar o login por e-mail/senha.** Não existe comando de CLI
  para isso — acesse [Firebase Console → Authentication → Sign-in method](https://console.firebase.google.com/project/stack-up-917a4/authentication/providers)
  e habilite o provedor **E-mail/senha**. Sem esse passo, cadastro e login
  falham com erro de configuração.
- `ios/Runner/GoogleService-Info.plist` não foi gerado (este ambiente não
  tem Xcode/macOS). Rode `flutterfire configure` novamente numa máquina Mac
  antes de buildar para iOS — os valores em `firebase_options.dart` já estão
  corretos para o app iOS registrado no projeto.

## Como rodar

### 1. Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (canal stable,
  testado com a 3.47.2).

### 2. Rodar o app

```bash
flutter pub get
flutter run -d chrome   # ou -d <device-id> para Android/iOS
```

### 3. Deploy do web app no Firebase Hosting

```bash
npm install -g firebase-tools   # se ainda não tiver o firebase-tools
firebase login
flutter build web --release
firebase deploy --only hosting
```

### Se precisar reconfigurar o Firebase (outro projeto, novas plataformas, etc.)

```bash
dart pub global activate flutterfire_cli
flutterfire configure
firebase deploy --only firestore:rules,firestore:indexes
```

## Modelo de dados (Firestore)

```
squads/{squadId}
  name: string
  stack: string          # ex: "Flutter", "Backend", "DevOps"...
  memberCount: number

users/{uid}
  name: string
  email: string
  squadId: string | null
  squadName: string | null
  stack: string | null
  totalXp: number         # agregado, recalculado a cada avaliação
  createdAt: timestamp

users/{uid}/skills/{skillId}
  name: string
  rating: number (0-10)
  updatedAt: timestamp
```

O catálogo de skills sugeridas por stack (Flutter, Backend, DevOps, Design,
QA, Data) fica em `lib/core/gamification/skill_catalog.dart` — é só um mapa
Dart estático, fácil de editar sem precisar mexer no banco. Qualquer
desenvolvedor também pode adicionar uma skill customizada que não esteja no
catálogo.

## Regras de gamificação

Toda a lógica de XP/nível é pura e testada em
`lib/core/gamification/level_calculator.dart` (veja `test/widget_test.dart`):

- Cada skill avaliada de 0 a 10 vale `rating * 100` XP.
- XP total = soma de todas as skills avaliadas.
- Nível geral: Iniciante (0) → Aprendiz (500) → Pleno (1500) → Sênior (3000)
  → Especialista (5000+).

## Estrutura de pastas

```
lib/
  core/            # tema, DI, navegação, regras de gamificação
  design_system/   # componentes de UI reutilizáveis (botões, inputs, barras de XP...)
  features/
    alert/                 # sistema global de alertas
    authentication/        # login e cadastro (Firebase Auth)
    squad/                 # onboarding: escolher/criar squad
    dashboard/              # "Minhas Skills" — autoavaliação
    team/                   # squad: ranking e perfil de cada colega (somente leitura)
    profile/                # perfil próprio, radar de skills, logout
```
