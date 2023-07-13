import 'livro.dart';

class Review {
  Livro livro;
  String nomePessoa;
  int avaliacao;
  String comentario;
  String photoURL;

  Review(this.livro, this.nomePessoa, this.photoURL, this.avaliacao, this.comentario);

  Map<String, dynamic> toJson() {
    return {
      'livro': livro.toJson(),
      'nomePessoa': nomePessoa,
      'photoURL': photoURL,
      'avaliacao': avaliacao,
      'comentario': comentario,
    };
  }
}
