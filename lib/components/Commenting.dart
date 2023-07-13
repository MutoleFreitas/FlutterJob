import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:vid_viewr/config/database.dart';
import 'package:vid_viewr/config/models/Livro.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vid_viewr/config/utils.dart';
import 'dart:typed_data';
import 'dart:io';

/*
class Comments extends StatefulWidget {
  @override
  _TestMeState createState() => _TestMeState();
}

class _TestMeState extends State<Comments> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [
    {
      'name': 'Chuks Okwuenu',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to code',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://www.adeleyeayodeji.com/img/IMG_20200522_121756_834_2.jpg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Tunde Martins',
      'pic': 'assets/img/userpic.jpg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
  ];

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: CommentBox.commentImageParser(
                          imageURLorPath: data[i]['pic'])),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
              trailing: TColor.fromARGB(255, 30, 125, 233)GBO(47, 128, 235, 1)RGB(255, 30, 125, 233)['date'], style: TextStyle(fontSize: 10)),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comment Page"),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        child: CommentBox(
          userImage: CommentBox.commentImageParser(
              imageURLorPath: "assets/img/userpic.jpg"),
          child: commentChild(filedata),
          labelText: 'Add a Comment...',
          errorText: 'Your Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              setState(() {
                var value = {
                  'name': 'New User',
                  'pic':
                      'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                  'message': commentController.text,
                  'date': '2021-01-01 12:00:00'
                };
                filedata.insert(0, value);
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

class Livro {
  // Placeholder class for Livro
  String titulo;
  String autor;
  String editora;
  int anoPublicacao;
  String genero;
  String? photoURL;
  bool promocao;
  double preco;

  Livro(this.titulo, this.autor, this.editora, this.anoPublicacao, this.genero,
      this.promocao, this.preco,
      [this.photoURL]);

  /*Map<String, dynamic> toJson() {
    return {}; // Implement toJson() method for Livro if needed
  }*/

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

//Object for making them
class Review {
  Livro livro;
  String nomePessoa;
  int avaliacao;
  String comentario;
  String photoURL;

  Review(this.livro, this.nomePessoa, this.photoURL, this.avaliacao,
      this.comentario);

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

class CommentBox extends StatefulWidget {
  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  List<Review> comments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment Box'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(comment.photoURL),
                  ),
                  title: Text(comment.nomePessoa),
                  subtitle: Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Text(comment.avaliacao.toString()),
                    ],
                  ),
                  trailing: Text(comment.comentario),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Add a Comment...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Profile Picture URL',
                  ),
                  onChanged: (value) {
                    // Save the profile picture URL
                  },
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  onChanged: (value) {
                    // Save the name
                  },
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Text('Rating: '),
                    DropdownButton<int>(
                      value: 1,
                      items: [1, 2, 3, 4, 5]
                          .map((value) => DropdownMenuItem<int>(
                                value: value,
                                child: Text(value.toString()),
                              ))
                          .toList(),
                      onChanged: (value) {
                        // Save the rating
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Comment',
                  ),
                  onChanged: (value) {
                    // Save the comment
                  },
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Add the comment to the list
                    setState(() {
                      comments.add(
                        Review(
                          Livro('Book2', 'luc', 'nirv', 1992, 'comedy', false,
                              1233), // Create an instance of Livro or use an existing one
                          'd aad', // Replace with the saved name
                          'assets/cain.jpg', // Replace with the saved profile picture URL
                          4, // Replace with the saved rating
                          'Hello', // Replace with the saved comment
                        ),
                      );
                    });
                  },
                  child: Text('Add Comment'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CommentBox(),
  ));
}







import 'package:flutter/material.dart';
import 'livro.dart';
import 'review.dart';

class CommentBox extends StatefulWidget {
  final Livro livro;

  CommentBox(this.livro);

  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  int _rating = 0;
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Comments',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.livro.comments.length,
          itemBuilder: (context, index) {
            final comment = widget.livro.comments[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(comment.photoURL),
              ),
              title: Text(comment.nomePessoa),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 18),
                      SizedBox(width: 5),
                      Text(comment.avaliacao.toString()),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(comment.comentario),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 20),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Your Name'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rating: '),
                  DropdownButton<int>(
                    value: _rating,
                    onChanged: (value) {
                      setState(() {
                        _rating = value;
                      });
                    },
                    items: [1, 2, 3, 4, 5].map((rating) {
                      return DropdownMenuItem<int>(
                        value: rating,
                        child: Text(rating.toString()),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _commentController,
                decoration: InputDecoration(labelText: 'Comment'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your comment';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    final review = Review(
                      widget.livro,
                      _nameController.text,
                      '',
                      _rating,
                      _commentController.text,
                    );
                    setState(() {
                      widget.livro.comments.add(review);
                      _nameController.clear();
                      _rating = 0;
                      _commentController.clear();
                    });
                  }
                },
                child: Text('Add Comment'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
*/