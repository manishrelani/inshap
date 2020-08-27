import 'package:inshape/providers/session.dart';

class Jwt{
  String jwtWebToken() {
    return SessionProvider.jwt;
  }
} 