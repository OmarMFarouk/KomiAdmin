class AuthModel {
  final String adminId, password;
  AuthModel({required this.adminId, required this.password});

  Map<String, dynamic> toJson() => {
        'admin_id': adminId,
        'password': password,
        'fcm_token': '' //SharedPref.localStorage?.getString('token')
      };
}
