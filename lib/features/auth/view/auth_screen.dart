import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final email = TextEditingController(text: "admin@admin.com");
  final password = TextEditingController(text: "admin");
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Логотип или заголовок
              Column(
                children: [
                  const SizedBox(height: 32.0),
                  Icon(Icons.lock_outline,
                      size: 100, color: theme.primaryColor),
                  const SizedBox(height: 16.0),
                  Text(
                    "Добро пожаловать",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Войдите, чтобы продолжить",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.hintColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),

              // Поле ввода email
              TextField(
                controller: email,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Color.fromARGB(255, 78, 78, 78)),
              ),
              const SizedBox(height: 16.0),

              // Поле ввода пароля
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Пароль",
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                style: const TextStyle(color: Color.fromARGB(255, 82, 82, 82)),
              ),
              const SizedBox(height: 24.0),

              // Кнопка "Войти"
              ElevatedButton(
                onPressed: () async {
                  if (email.text.isNotEmpty && password.text.isNotEmpty) {
                    try {
                      final AuthResponse res =
                          await supabase.auth.signInWithPassword(
                        email: email.text,
                        password: password.text,
                      );
                      final Session? session = res.session;
                      final User? user = res.user;
                      debugPrint("!!!!!!!!!!! ${user?.id}");
                      AutoRouter.of(context).push(const HomeRoute());
                    } on Exception catch (e) {}
                  }
                },
                child: const Text("Войти"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Кнопка "Зарегистрироваться"
              TextButton(
                onPressed: () {
                  AutoRouter.of(context).push(const RegistrationRoute());
                },
                child: const Text("Зарегистрироваться"),
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 32.0),

              // Дополнительный текст
              Center(
                child: Text(
                  "Экран аутентификации",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.hintColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
