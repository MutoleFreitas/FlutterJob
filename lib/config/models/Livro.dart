class Livro {
  String titulo;
  String autor;
  String editora;
  int anoPublicacao;
  String genero;
  String? photoURL;
  bool promocao;
  double preco;

  Livro(this.titulo, this.autor, this.editora, this.anoPublicacao, this.genero, this.promocao, this.preco,
      [this.photoURL]);

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'autor': autor,
      'editora': editora,
      'anoPublicacao': anoPublicacao,
      'genero': genero,
      'promocao': promocao,
      'preco': preco,
      'photoURL': photoURL
    };
  }
}