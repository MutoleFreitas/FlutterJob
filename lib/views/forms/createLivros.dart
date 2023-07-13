import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:vid_viewr/config/database.dart';
import 'package:vid_viewr/config/models/Livro.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vid_viewr/config/utils.dart';
import 'dart:typed_data';
import 'dart:io';
import 'dart:html' as html;

class LivroForm extends StatefulWidget {
  @override
  _LivroFormState createState() => _LivroFormState();
}

class _LivroFormState extends State<LivroForm> {
  final _formKey = GlobalKey<FormState>();
  Livro _livro = Livro('', '', '', 0, '', false, 0.0, null);
  final DatabaseService db = DatabaseService();
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // You can now use the _livro object with the form data
      print(_livro.toJson());
      db.createLivro(_livro);
      Navigator.pop(context);

    }
  }

  void _pickImage() async {
    final FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        final file = files[0];
        final reader = html.FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            _livro.photoURL = reader.result as String?;
          });
        });

        reader.readAsDataUrl(file);

        String fileUrl =
            'https://example.com/file.pdf'; // Replace with the URL of the file you want to download
        String savePath =
            'testCM.jpeg'; // Replace with the desired save path on the device
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Livro Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
                onChanged: (value) {
                  _livro.titulo = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Autor'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the author';
                  }
                  return null;
                },
                onChanged: (value) {
                  _livro.autor = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Editora'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the publisher';
                  }
                  return null;
                },
                onChanged: (value) {
                  _livro.editora = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ano de Publicação'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the year of publication';
                  }
                  int? year = int.tryParse(value);
                  if (year == null || year <= 0) {
                    return 'Please enter a valid year';
                  }
                  return null;
                },
                onChanged: (value) {
                  _livro.anoPublicacao = int.tryParse(value!)!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gênero'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the genre';
                  }
                  return null;
                },
                onChanged: (value) {
                  _livro.genero = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the price';
                  }
                  double? price = double.tryParse(value);
                  if (price == null || price <= 0) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
                onChanged: (value) {
                  _livro.preco = double.tryParse(value!)!;
                },
              ),
              CheckboxListTile(
                title: Text('Promoção'),
                value: _livro.promocao,
                onChanged: (value) {
                  setState(() {
                    _livro.promocao = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              _livro.photoURL != null
                  ? Image.network(
                      _livro.photoURL!,
                      height: 100,
                    )
                  : SizedBox(),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Select Image'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
