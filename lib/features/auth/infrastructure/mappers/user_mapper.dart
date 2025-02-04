import 'package:teslo_shop/features/auth/domain/entities/entities.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> data) => User(
        id: data["id"] ?? "",
        email: data["email"] ?? "",
        fullName: data["fullName"] ?? "",
        roles: List<String>.from(data["roles"].map((role) => role) ?? []),
        token: data["token"] ?? "",
      );
}
