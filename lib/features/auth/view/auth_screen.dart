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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: email,
              style: const TextStyle(color: Color.fromARGB(255, 78, 78, 78)),
            ),
            TextField(
              controller: password,
              style: const TextStyle(color: Color.fromARGB(255, 82, 82, 82)),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (email.text.isNotEmpty && password.text.isNotEmpty) {
                    final AuthResponse res =
                        await supabase.auth.signInWithPassword(
                      email: email.text,
                      password: password.text,
                    );
                    final Session? session = res.session;
                    final User? user = res.user;
                    debugPrint("!!!!!!!!!!! ${user?.id}");
                    AutoRouter.of(context).push(const ProductCategoriesRoute());
                  }
                },
                child: const Text("Войти")),
            ElevatedButton(
                onPressed: () async {
                  AutoRouter.of(context).push(const RegistrationRoute());
                },
                child: const Text("Зарегистрироваться")),
            const Text("Экран аутентификации")
          ],
        ),
      ),
    );
  }
}
