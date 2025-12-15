import 'package:dental_pt/features/Auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> logIn({required String email, required String password});
  Future<void> signUp({required UserModel userModel});
  Future<UserModel> getCurrentUser();
  Future<void> logout();
}

class AuthRemoteDatasourcesImpl implements AuthRemoteDataSource {
  final supabase = Supabase.instance.client;
  @override
  Future<UserModel> logIn(
      {required String email, required String password}) async {
    try {
      final authResponse = await supabase.auth
          .signInWithPassword(email: email, password: password);
      final User? user = authResponse.user;
      if (user != null) {
        final userData =
            await supabase.from("users").select().eq('uuid', user.id).single();
        // Store the session tokens for persistence
        final session = authResponse.session;
        // ignore: unnecessary_null_comparison
        if (session != null && session.accessToken != null && session.refreshToken != null) {
          _storeSessionTokens(session.accessToken, session.refreshToken!);
        }
        return UserModel.fromJson(userData);
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      throw Exception('Error:in remote data source in "log in" $e');
    }
  }

  void _storeSessionTokens(String accessToken, String refreshToken) {
    // Store tokens for later use (they will be used by Supabase client automatically)
    // but we keep them for reference
  }

  @override
  Future<void> signUp({required UserModel userModel}) async {
    try {
      final authResponse = await supabase.auth
          .signUp(password: userModel.password, email: userModel.email);
      final User? user = authResponse.user;
      if (user != null) {
        final jsonData = userModel.toJson();
        jsonData['uuid'] = user.id;
        // Remove the 'id' field to let the database auto-generate it
        jsonData.remove('id');
        await supabase.from("users").insert(jsonData);
      } else {
        throw Exception('Failed to create auth user');
      }
    } catch (e) {
      throw Exception('Error in remote data source in "sign up": $e');
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final User? user = supabase.auth.currentUser;
      if (user != null) {
        final userData =
            await supabase.from("users").select().eq('uuid', user.id).single();
        return UserModel.fromJson(userData);
      } else {
        throw Exception('No current user');
      }
    } catch (e) {
      throw Exception('Error in remote data source in "getCurrentUser": $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      throw Exception('Error in remote data source in "logout": $e');
    }
  }
}

