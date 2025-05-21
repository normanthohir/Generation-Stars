import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  static final supabase = Supabase.instance.client;

  static Future<void> lengkapiProfile({
    required String nama,
    required String tanggalLahir,
    required String tanggalKehamilan,
    required int tinggiBadan,
    required int beratBadan,
    required String alamat,
    File? fileGambar,
  }) async {
    final userId = supabase.auth.currentUser?.id;
    String? gambarUrl;
    try {
      if (fileGambar != null) {
        final bytes = await fileGambar!.readAsBytes();
        final path =
            'foto-profile/${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
        await supabase.storage.from('foto-profile').uploadBinary(path, bytes);
        gambarUrl = supabase.storage.from('foto-profile').getPublicUrl(path);
      }

      await supabase.from('profile').upsert({
        'id': userId,
        'nama': nama,
        'tanggal_lahir': tanggalLahir,
        'tanggal_kehamilan': tanggalKehamilan,
        'tinggi_badan': tinggiBadan,
        'berat_badan': beratBadan,
        'alamat': alamat,
        'foto_profile': gambarUrl,
      });
    } catch (e) {
      print('error: $e');
    }
    return null;
  }

  static Future<Map<String, dynamic>?> getCurrentUserProfile() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId != null) {
      try {
        final response = await Supabase.instance.client
            .from('profile')
            .select('*')
            .eq('id', userId)
            .single();
        return response as Map<String, dynamic>?;
      } catch (e) {
        print('error: $e');
        return null;
      }
    }
    return null;
  }

  // static Future<Map<String, dynamic>?> getCurrentUserData() async {
  //   final userId = supabase.auth.currentUser?.id;
  //   if (userId != null) {
  //     try {
  //       final response = await Supabase.instance.client
  //           .from('auth.users')
  //           .select('*')
  //           .eq('id', userId)
  //           .single();
  //       return response as Map<String, dynamic>?;
  //     } catch (e) {
  //       print('error: $e');
  //       return null;
  //     }
  //   }
  //   return null;
  // }

  Future<void> updateProfile({
    required String nama,
    required String tanggalLahir,
    required String tanggalKehamilan,
    required int tinggiBadan,
    required int beratBadan,
    required String alamat,
    File? fileGambar,
  }) async {
    final user = supabase.auth.currentUser?.id;
    if (user != null) {
      try {
        final dataUpdate = {
          'nama': nama,
          'tanggal_lahir': tanggalLahir,
          'tanggal_kehamilan': tanggalKehamilan,
          'tinggi_badan': tinggiBadan,
          'berat_badan': beratBadan,
          'alamat': alamat,
        };

        if (fileGambar != null) {
          // ambil foto profile lama
          final existingProfile = await supabase
              .from('profile')
              .select('foto_profile')
              .eq('id', user)
              .single();

          final gambarLamaUrl = existingProfile['foto_profile'];
          // hapus foto profile lama
          // hapus foto lama jika ada
          if (gambarLamaUrl != null) {
            final publicUrlPrefix =
                supabase.storage.from('foto-profile').getPublicUrl('');
            final pathLama = gambarLamaUrl.replaceFirst(publicUrlPrefix, '');
            await supabase.storage
                .from('foto-profile')
                .remove(['foto-profile/$pathLama']);
          }
          // upload foto profile baru
          final pathBaru =
              'foto-profile/${user}_${DateTime.now().millisecondsSinceEpoch}.jpg';
          await supabase.storage
              .from('foto-profile')
              .upload(pathBaru, fileGambar);

          final gambarBaruURL =
              supabase.storage.from('foto-profile').getPublicUrl(pathBaru);
          dataUpdate['foto_profile'] = gambarBaruURL;
        }

        await supabase.from('profile').update(dataUpdate).eq('id', user);
      } catch (e) {
        print('Error: $e');
      }
    }
    return null;
  }
}
