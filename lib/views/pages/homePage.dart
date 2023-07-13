import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:vid_viewr/components/loading.dart';
import 'package:vid_viewr/config/constants.dart';
import 'package:vid_viewr/config/models/Livro.dart';
import 'package:vid_viewr/views/forms/createLivros.dart';
import 'package:vid_viewr/views/home/detailsLivro.dart';
import '/slideshow.dart';
import 'package:vid_viewr/config/database.dart';
import 'package:provider/provider.dart';
import 'package:vid_viewr/config/models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    var user = null;
    int _privilegio = 0;
    try {
      user = Provider.of<LibUser>(context);
    } catch (e) {}

    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  headerText("Livros em destaque"),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          db.getPriv(user.uid).then((privilegio) {
                            if (privilegio != null) {
                              _privilegio = int.parse(privilegio);
                              print(
                                  privilegio); // or use the privilegio value as needed
                              if (_privilegio == 1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LivroForm()),
                                );
                              }
                            }
                          });
                        });
                      },
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.add),
                          Text(" Adicionar"),
                        ],
                      ))
                ],
              ),
              slideShowSection(),
              headerText("Livros recentemente adicionados"),
              bookGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Container headerText(String header) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 69.0, vertical: 8.0),
      child: Text(header, style: titleStyle),
    );
  }

  Container bookGrid() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      height: 700,
      child: FutureBuilder<List<Livro>>(
        future: db.getLivros(false, 8),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Livro> livros = snapshot.data!;
            final orientation = MediaQuery.of(context).orientation;
            return GridView.count(
              mainAxisSpacing: 100.0,
              crossAxisSpacing: 2.0,
              childAspectRatio: orientation == Orientation.portrait ? .8 : 1.8,
              crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
              padding: EdgeInsets.all(16),
              children: livros.map((livro) => simpleCard(livro)).toList(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Loading();
          }
        },
      ),
    );
  }

  InkWell simpleCard(Livro livro) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LivroDetailsPage(livro: livro),
          ),
        );
      },
      child: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(livro.titulo, style: smallTitleStyle),
              Text(livro.autor, style: smallContentStyle),
              Text(livro.preco.toString() + " MZN", style: smallContentStyle),
              livro.photoURL != null
                  ? Expanded(
                      child: Image.network(livro.photoURL!),
                    )
                  : SizedBox(),
            ],
          )),
    );
  }

  Container slideShowSection() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      height: 500,
      child: FutureBuilder<List<Livro>>(
        future: db.getLivros(true, 5),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Livro> livros = snapshot.data!;
            return SlideShow(
              livros: livros,
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
