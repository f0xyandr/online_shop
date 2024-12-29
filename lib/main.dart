import 'package:crypto_coins_list/crypto_coins_list_app.dart';
import 'package:crypto_coins_list/firebase_options.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:crypto_coins_list/repositories/products/products_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'repositories/crypto_coins/models/crypto_coin_details.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);

  await Hive.initFlutter();
  Hive.registerAdapter(CryptoCoinAdapter());
  Hive.registerAdapter(CryptoCoinDetailAdapter());

  final cryptoCoinsBox = await Hive.openBox<CryptoCoin>("crypto_coins_box");

  WidgetsFlutterBinding.ensureInitialized();
  const String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InByZ2JnYmhnd3B6bHZ0ZnZnZ3NqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI1MjEyMzcsImV4cCI6MjA0ODA5NzIzN30.PAd4rAFyEGeSLpuRTcMOyTnYZqtmLA4SHoIi2uvOBns';
  await Supabase.initialize(
    url: 'https://prgbgbhgwpzlvtfvggsj.supabase.co',
    anonKey: anonKey,
  );
  final supabase = Supabase.instance.client;

  GetIt.I.registerSingleton(supabase);
  GetIt.I.registerLazySingleton<ProductsRepository>(
    () => ProductsRepository(dio: Dio()),
  );

  final dio = Dio();
  dio.interceptors.add(TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(printResponseData: false)));

  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
    () => CryptoCoinsRepository(dio: dio, cryptoCoinsBox: cryptoCoinsBox),
  );

  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  talker.info(app.options.projectId);
  Bloc.observer = TalkerBlocObserver(talker: talker);

  FlutterError.onError =
      (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

  runApp(const CryptoCurrenciesListApp());
}
