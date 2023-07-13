import 'package:flutter/material.dart';
import 'package:vid_viewr/views/home/detailsLivro.dart';
import 'config/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:vid_viewr/config/models/Livro.dart';

class SlideShow extends StatelessWidget {
  List<Livro> livros;
  SlideShow({super.key, required this.livros});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<int> cardList = List.generate(6, (index) => index + 1);
    final bool isSmallScreen = size.width < 600;
    PageController _controller =
        PageController(viewportFraction: isSmallScreen ? 1 : .7);

    return OrientationBuilder(
      builder: (context, orientation) {
        return PageView.builder(
          controller: _controller,
          itemCount: livros.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return bookCard(size, livros[index], context);
          },
        );
      },
    );
  }

  InkWell bookCard(Size size, Livro livro, BuildContext context) {
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
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    livro.preco.toString() + " MZN",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: '.SF UI Display',
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.withOpacity(0.69),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  livro.titulo,
                  style: titleStyle,
                ),
                SizedBox(height: 8),
                Text(
                  livro.autor,
                  style: contentStyle,
                ),
                SizedBox(height: 16),
                IconButton(
                    onPressed: () {},
                    icon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(CupertinoIcons.shopping_cart),
                        // Text(
                        //   'ADQUIRIR',
                        //   style: contentStyle,
                        // ),
                      ],
                    ))
              ],
            ),
            Container(
              height: size.width * .3,
              width: size.width * .2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      livro.photoURL!,
                    )),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.3),
                //     spreadRadius: 2,
                //     blurRadius: 5,
                //     offset: Offset(0, 3),
                //   ),
                // ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
