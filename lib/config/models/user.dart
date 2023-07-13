class LibUser {
  final String uid;
  final String displayName;
  final String email;
  final String phoneNumber;
  final String photoURL;
  final int privilege;

  LibUser(
      {required this.uid,
      required this.displayName,
      required this.email,
      required this.phoneNumber,
      required this.photoURL,
      required this.privilege});
}
