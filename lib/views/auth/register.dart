import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vid_viewr/components/loading.dart';
import 'package:vid_viewr/config/auth.dart';
import 'package:vid_viewr/config/constants.dart';
import 'package:vid_viewr/config/database.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  const Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final DatabaseService db = DatabaseService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "Registo",
                style: titleStyle,
              ),
              backgroundColor: Colors.grey[400],
              elevation: 0,
            ),
            backgroundColor: Colors.grey[100],
            body: Card(
              margin: EdgeInsets.all(18),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey[200],
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains("@")) {
                              return 'Por favor, insira um email válido!';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Email',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey[200],
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira a senha!';
                            } else if (value.length < 6) {
                              return 'Por favor, insira uma senha com mais de 6 caracteres!';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Senha',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.grey[500], // Background color
                          foregroundColor: Colors.white, // Text color
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0), // Rounded corners
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0), // Button padding
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });

                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);

                            if (result == null) {
                              setState(() {
                                error = "Username ou Password invalidos!";
                                loading = false;
                              });
                            } else {
                              db.createPriv(result.uid, result.privilege);
                            }
                          }
                        },
                        child: Text('Criar'),
                      ),
                      SizedBox(height: 16.0),
                      Text(error),
                      SizedBox(height: 16.0),
                      TextButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.grey[200], // Background color
                          foregroundColor: Colors.black45, // Text color
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0), // Rounded corners
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0), // Button padding
                        ),
                        onPressed: () {
                          widget.toggleView();
                        },
                        child: Text('Já possui uma conta? Faça login!'),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              // Perform sign in with Google logic
                            },
                            icon: Icon(Icons.mail),
                            label: Text('Criar conta com Google'),
                          ),
                          const SizedBox(width: 20),
                          OutlinedButton.icon(
                            onPressed: () async {
                              dynamic result = await _auth.signInAnon();
                              if (result == null) {
                                print("Erro: ao fazer login");
                              } else {
                                print("Login com sucesso");
                                print(result.uid);
                              }
                            },
                            icon: Icon(CupertinoIcons.person),
                            label: Text('Entrar anonimamente'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
