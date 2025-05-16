import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  /// 📌 **Login dengan Email dan Password**
  Future<AuthResponse> logIn({
    required String email,
    required String password,
  }) async {
    return await supabase.auth
        .signInWithPassword(email: email, password: password);
  }

  /// 📌 **register dengan email dan PAssword**
  Future<AuthResponse> regiSter({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signUp(email: email, password: password);
  }

  // 📌 **logout**
  Future<void> logOut() async => await supabase.auth.signOut();
}
