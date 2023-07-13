// import 'dart:js_interop';

// import 'package:flutter/material.dart';
// import 'livro.dart';
// import 'review.dart';

// class CommentBox extends StatefulWidget {
//   final Livro livro;

//   CommentBox(this.livro);

//   @override
//   _CommentBoxState createState() => _CommentBoxState();
// }

// class _CommentBoxState extends State<CommentBox> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _nameController = TextEditingController();
//   int _rating = 0;
//   TextEditingController _commentController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           'Comments',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         ListView.builder(
//           shrinkWrap: true,
//           itemCount: widget.livro.comments.length,
//           itemBuilder: (context, index) {
//             final comment = widget.livro.comments[index];
//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: NetworkImage(comment.photoURL),
//               ),
//               title: Text(comment.nomePessoa),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.star, color: Colors.yellow, size: 18),
//                       SizedBox(width: 5),
//                       Text(comment.avaliacao.toString()),
//                     ],
//                   ),
//                   SizedBox(height: 5),
//                   Text(comment.comentario),
//                 ],
//               ),
//             );
//           },
//         ),
//         SizedBox(height: 20),
//         Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'Your Name'),
//                 validator: (value) {
//                   if (value.isNull) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Rating: '),
//                   DropdownButton<int>(
//                     value: _rating,
//                     onChanged: (value) {
//                       setState(() {
//                         _rating = value!;
//                       });
//                     },
//                     items: [1, 2, 3, 4, 5].map((rating) {
//                       return DropdownMenuItem<int>(
//                         value: rating,
//                         child: Text(rating.toString()),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 controller: _commentController,
//                 decoration: InputDecoration(labelText: 'Comment'),
//                 validator: (value) {
//                   if (value.isNull) {
//                     return 'Please enter your comment';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     final review = Review(
//                       widget.livro,
//                       _nameController.text,
//                       '',
//                       _rating,
//                       _commentController.text,
//                     );
//                     setState(() {
//                       widget.livro.comments.add(review);
//                       _nameController.clear();
//                       _rating = 0;
//                       _commentController.clear();
//                     });
//                   }
//                 },
//                 child: Text('Add Comment'),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
