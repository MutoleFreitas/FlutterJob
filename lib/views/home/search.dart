// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(BookSearchApp());
// }

// class BookSearchApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Busca de Livros',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: BookSearchScreen(),
//     );
//   }
// }

// class BookSearchScreen extends StatefulWidget {
//   @override
//   _BookSearchScreenState createState() => _BookSearchScreenState();
// }

// class _BookSearchScreenState extends State<BookSearchScreen> {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   String termoPesquisa = '';

//   Future<List<Livro>> searchBooks(String searchTerm) async {
//     final snapshot = await firestore.collection('livros').get();
//     final List<Livro> livros = [];
//     snapshot.docs.forEach((doc) {
//       final livro = Livro.fromSnapshot(doc);
//       if (livro.titulo.toLowerCase().contains(searchTerm.toLowerCase()) ||
//           livro.autor.toLowerCase().contains(searchTerm.toLowerCase()) ||
//           livro.genero.toLowerCase().contains(searchTerm.toLowerCase())) {
//         livros.add(livro);
//       }
//     });
//     return livros;
//   }

//   void editarLivro(Livro livro) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         String novoTitulo = livro.titulo;
//         String novoAutor = livro.autor;
//         String novoGenero = livro.genero;

//         return AlertDialog(
//           title: Text('Editar Livro'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 onChanged: (value) {
//                   novoTitulo = value;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Novo Título',
//                 ),
//               ),
//               TextField(
//                 onChanged: (value) {
//                   novoAutor = value;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Novo Autor',
//                 ),
//               ),
//               TextField(
//                 onChanged: (value) {
//                   novoGenero = value;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Novo Gênero',
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 livro.titulo = novoTitulo;
//                 livro.autor = novoAutor;
//                 livro.genero = novoGenero;
//                 livro.update();
//                 Navigator.pop(context);
//               },
//               child: Text('Salvar'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancelar'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void adicionarLivro() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         String novoTitulo = '';
//         String novoAutor = '';
//         String novoGenero = '';

//         return AlertDialog(
//           title: Text('Adicionar Livro'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 onChanged: (value) {
//                   novoTitulo = value;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Título',
//                 ),
//               ),
//               TextField(
//                 onChanged: (value) {
//                   novoAutor = value;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Autor',
//                 ),
//               ),
//               TextField(
//                 onChanged: (value) {
//                   novoGenero = value;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Gênero',
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 final livro = Livro(
//                   titulo: novoTitulo,
//                   autor: novoAutor,
//                   genero: novoGenero,
//                 );
//                 livro.save();
//                 Navigator.pop(context);
//               },
//               child: Text('Adicionar'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancelar'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Busca de Livros'),
//       ),
//       body: Column(
//         children: [
//           TextField(
//             onChanged: (value) {
//               setState(() {
//                 termoPesquisa = value;
//               });
//             },
//             decoration: InputDecoration(
//               labelText: 'Pesquisar',
//             ),
//           ),
//           Expanded(
//             child: FutureBuilder<List<Livro>>(
//               future: searchBooks(termoPesquisa),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Erro ao carregar os livros.'));
//                 } else {
//                   final livros = snapshot.data!;
//                   return ListView.builder(
//                     itemCount: livros.length,
//                     itemBuilder: (context, index) {
//                       final livro = livros[index];
//                       return ListTile(
//                         title: Text(livro.titulo),
//                         subtitle: Text('Autor: ${livro.autor}, Gênero: ${livro.genero}'),
//                         trailing: IconButton(
//                           icon: Icon(Icons.edit),
//                           onPressed: () {
//                             editarLivro(livro);
//                           },
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           adicionarLivro();
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// class Livro {
//   String id;
//   String titulo;
//   String autor;
//   String genero;

//   Livro({
//     required this.id,
//     required this.titulo,
//     required this.autor,
//     required this.genero,
//   });

//   Livro.fromSnapshot(DocumentSnapshot snapshot)
//       : id = snapshot.id,
//         titulo = snapshot.get('titulo'),
//         autor = snapshot.get('autor'),
//         genero = snapshot.get('genero');

//   Future<void> save() async {
//     final livroRef = FirebaseFirestore.instance.collection('livros').doc();
//     await livroRef.set({
//       'titulo': titulo,
//       'autor': autor,
//       'genero': genero,
//     });
//     id = livroRef.id;
//   }

//   Future<void> update()async {
//     final livroRef = FirebaseFirestore.instance.collection('livros').doc(id);
//     await livroRef.update({
//       'titulo': titulo,
//       'autor': autor,
//       'genero': genero,
//     });
//   }

//   Future<void> delete() async {
//     final livroRef = FirebaseFirestore.instance.collection('livros').doc(id);
//     await livroRef.delete();
//   }
// }
