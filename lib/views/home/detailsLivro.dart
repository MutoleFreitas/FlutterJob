import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vid_viewr/config/models/Livro.dart';

class LivroDetailsPage extends StatelessWidget {
  final Livro livro;

  LivroDetailsPage({required this.livro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do livro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Título: ${livro.titulo}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Autor: ${livro.autor}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Editora: ${livro.editora}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Ano de Publicação: ${livro.anoPublicacao}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Gênero: ${livro.genero}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Preço: R\$ ${livro.preco.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: 200,
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.shopping_cart),
                        Text("Adquirir"),
                      ],
                    )),
              ),
              SizedBox(height: 8),
              Text(
                'Promoção: ${livro.promocao ? 'Sim' : 'Não'}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16),
              if (livro.photoURL != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    livro.photoURL!,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
