class UserProfile {
  String? uid;
  String? displayName;
  String? email;
  String? photoUrl;
  bool emailVerified;
  String? phoneNumber;
  String? name;

  UserProfile({
    this.uid,
    this.displayName,
    this.email,
    this.photoUrl,
    this.emailVerified = false,
    this.phoneNumber,
    this.name,
  });
}
