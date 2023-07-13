class Privilegio{

  String uid;
  int privilegio;

  Privilegio(this.uid, this.privilegio);

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'privilegio': privilegio
    };
  }

}