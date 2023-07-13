import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vid_viewr/config/models/Livro.dart';
import 'package:vid_viewr/config/models/Privilegio.dart';

class DatabaseService {
  final db = FirebaseFirestore.instance;

  void createPriv(String uid, int privilegio) {
    Privilegio priv = Privilegio(uid, privilegio);
    db.collection("privilegios").doc(uid).set(priv.toJson());
  }

  Future<String?> getPriv(String uid) async {
    try {
      final DocumentSnapshot doc =
          await db.collection("privilegios").doc(uid).get();
      final data = doc.data() as Map<String, dynamic>;
      final privilegio = data['privilegio'];
      return privilegio.toString();
    } catch (e) {
      print("Error getting document: $e");
      return null; // or handle the error in an appropriate way
    }
  }

  void createLivro(Livro livro) async {
    Livro _livro = Livro(
        livro.titulo,
        livro.autor,
        livro.editora,
        livro.anoPublicacao,
        livro.genero,
        livro.promocao,
        livro.preco,
        livro.photoURL);
    print("Inserindo Livro");
    //Add document to Firestore with an auto-generated Id
    await db.collection('livros').add(_livro.toJson());
  }

  Future<List<Livro>> getLivros(bool getPromocao, int maxCount) async {
    List<Livro> livros = [];

    try {
      final querySnapshot = await db.collection("livros").get();
      print("Successfully completed");

      int count = 0; // Counter variable to track the number of books added

      for (var docSnapshot in querySnapshot.docs) {
        if (count >= maxCount) {
          break; // Break the loop if the maximum count is reached
        }

        Map<String, dynamic> livroData = docSnapshot.data();

        Livro livro = Livro(
          livroData['titulo'],
          livroData['autor'],
          livroData['editora'],
          livroData['anoPublicacao'],
          livroData['genero'],
          livroData['promocao'],
          livroData['preco'],
          livroData['photoURL'],
        );

        if (getPromocao == true) {
          if (livroData['promocao'] == true) {
            livros.add(livro);
            count++; // Increment the counter
          }
        }

        if (getPromocao == false) {
          livros.add(livro);
          count++; // Increment the counter
        }

        // print('${docSnapshot.id} => ${docSnapshot.data()}');
      }
    } catch (e) {
      print("Error completing: $e");
    }

    return livros;
  }
}