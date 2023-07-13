import 'livro.dart';

class Emprestimo {

  Livro livro;
  String nomePessoa;
  DateTime dataEmprestimo;
  DateTime? dataDevolucao;

  Emprestimo(this.livro, this.nomePessoa, this.dataEmprestimo, [this.dataDevolucao]);
  
  Map<String, dynamic> toJson() {
    return {
      'livro': livro.toJson(),
      'nomePessoa': nomePessoa,
      'dataEmprestimo': dataEmprestimo,
      'dataDevolucao': dataDevolucao,
    };
  }

}
