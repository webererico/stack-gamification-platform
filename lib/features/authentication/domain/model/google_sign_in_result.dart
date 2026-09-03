class GoogleSignInResult {
  final String uid;
  final String? name;
  final String? email;
  final String? photoUrl;
  final bool isNewUser;

  const GoogleSignInResult({
    required this.uid,
    required this.isNewUser,
    this.name,
    this.email,
    this.photoUrl,
  });
}
