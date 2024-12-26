import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
  primarySwatch: Colors.teal,
  primaryColor: Colors.teal,
  dividerColor: Colors.white24,

  // Тема для AppBar
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  ),

  // Тема для ListTile
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.white,
  ),

  // Общая текстовая тема
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Color.fromARGB(255, 73, 73, 73),
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    labelSmall: TextStyle(
      color: Color.fromARGB(255, 73, 73, 73),
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
    labelMedium: TextStyle(
      color: Color.fromARGB(255, 73, 73, 73),
    ),
    headlineMedium: TextStyle(
      color: Color.fromARGB(255, 73, 73, 73),
      fontWeight: FontWeight.w500,
      fontSize: 24,
    ),
  ),

  // Тема для ElevatedButton
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, // Цвет текста
      backgroundColor: Colors.teal, // Цвет кнопки
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    ),
  ),

  // Тема для TextButton
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.teal,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  // Тема для TextField
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color.fromARGB(255, 240, 240, 240),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: Colors.teal, width: 2.0),
    ),
    labelStyle: TextStyle(
      color: Color.fromARGB(255, 73, 73, 73),
      fontSize: 14,
    ),
    hintStyle: TextStyle(
      color: Colors.grey,
      fontSize: 14,
    ),
  ),

  // Тема для TabBar
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.teal,
    unselectedLabelColor: Colors.grey,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: Colors.teal, width: 3.0),
    ),
  ),

  // Тема для BottomNavigationBar
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.teal,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),

  // Тема для FloatingActionButton
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.teal,
    foregroundColor: Colors.white,
  ),
);
