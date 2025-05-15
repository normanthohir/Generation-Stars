import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  /// 📌 **Login dengan Email dan Password**
  Future<AuthResponse> signInWithPassword({
    required String email,
    required String password,
  }) async {
    return await supabase.auth
        .signInWithPassword(email: email, password: password);
  }

  /// 📌 **register dengan email dan PAssword**
  Future<AuthResponse> signUpWithPassword({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signUp(email: email, password: password);
  }
}
