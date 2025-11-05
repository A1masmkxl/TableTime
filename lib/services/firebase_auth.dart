import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Текущий пользователь (или null, если не вошёл)
  static User? get currentUser => _auth.currentUser;

  /// Проверка, вошёл ли пользователь
  static bool get isLoggedIn => _auth.currentUser != null;

  /// Регистрация
  static Future<User?> register({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _showError(context, e.message ?? 'Ошибка регистрации');
      return null;
    }
  }

  /// Вход
  static Future<User?> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _showError(context, e.message ?? 'Ошибка входа');
      return null;
    }
  }

  /// Выход
  static Future<void> logout() async {
    await _auth.signOut();
  }

  /// Вспомогательная функция показа ошибок
  static void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
