# Tappo Streaming App

## Stack
- Flutter (single codebase para Android, iOS, Android TV, tvOS)
- GoRouter para navegação
- Dio para HTTP client
- flutter_secure_storage para tokens
- just_audio para player de áudio/vídeo
- device_info_plus para identificador de dispositivo (MAC/UUID fallback)
- cached_network_image para imagens

## Como rodar

1. Instale o Flutter SDK (https://docs.flutter.dev/get-started/install)
2. Rode `flutter pub get` na pasta `tappo_app/`
3. Conecte um dispositivo ou inicie um emulador
4. Rode `flutter run`

## Estrutura
- `lib/main.dart` — Entry point, tema e rotas
- `lib/core/` — Tema, rede, storage, modelos, utilitários, widgets TV
- `lib/features/` — Autenticação, home, player, EPG, downloads, controle parental, perfis

## Configuração
- Copie `.env.example` para `.env` e ajuste `API_BASE_URL`
- Android: `android/app/src/main/AndroidManifest.xml`
- iOS: `ios/Runner/Info.plist`

## Telas implementadas
- Splash, Login, Cadastro, Home, Canais ao Vivo, VOD, EPG, Downloads, Controle Parental, Perfis, Player de Vídeo, Minha Conta
