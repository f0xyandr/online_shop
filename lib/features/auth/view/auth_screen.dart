import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/crypto_coin/bloc/crypto_coin_details_bloc.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
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
                    AutoRouter.of(context).push(const ProductRoute());
                  }
                },
                child: const Text("Войти")),
            ElevatedButton(
                onPressed: () async {
                  AutoRouter.of(context).push(const RegistrationRoute());
                },
                child: const Text("Зарегистрироваться")),
            ElevatedButton(
                onPressed: () async {
                  AutoRouter.of(context).push(const ProductRoute());
                },
                child: const Text("К гриду")),
            const Text("Экран аутентификации")
          ],
        ),
      ),
    );
  }
}
