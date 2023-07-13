import 'livro.dart';

class Reserva {

  Livro livro;
  String nomePessoa;
  DateTime dataReserva;

  Reserva(this.livro, this.nomePessoa, this.dataReserva);

  Map<String, dynamic> toJson() {
    return {
      'livro': livro.toJson(),
      'nomePessoa': nomePessoa,
      'dataReserva': dataReserva,
    };
  }
  
}
