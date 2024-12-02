import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

final email = TextEditingController();
final password = TextEditingController();
final supabase = Supabase.instance.client;

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: email,
              style: const TextStyle(color: Colors.white),
            ),
            TextField(
              controller: password,
              style: const TextStyle(color: Colors.white),
            ),
            ElevatedButton(
                onPressed: () async {
                  final AuthResponse res = await supabase.auth.signUp(
                    email: email.text,
                    password: password.text,
                  );
                  final Session? session = res.session;
                  final User? user = res.user;
                  debugPrint("sucess");
                },
                child: const Text("Войти")),
            ElevatedButton(
                onPressed: () async {
                  AutoRouter.of(context).push(const AuthRoute());
                },
                child: const Text("Войти")),
            const Text("Экран регистрации")
          ],
        ),
      ),
    );
  }
}
