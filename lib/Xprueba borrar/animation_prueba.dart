
import 'package:crud_sheety/models/user_model.dart';
import 'package:crud_sheety/service/service.dart';
import 'package:crud_sheety/utils/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AnimationPrueba extends StatefulWidget {
  const AnimationPrueba({super.key});

  @override
  State<AnimationPrueba> createState() => _AnimationPruebaState();
}

class _AnimationPruebaState extends State<AnimationPrueba> {
  final _pageCoffeController = PageController(
    viewportFraction: 0.3,
  );

  double _currentPage = 0.0;

  //Escuchar el scroll
  void _scrollControllerListener() {
    setState(() {
      _currentPage = _pageCoffeController.page!;
    });
  }

  @override
  void initState() {
    _pageCoffeController.addListener(_scrollControllerListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageCoffeController.removeListener(_scrollControllerListener);
    _pageCoffeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recurSoProduct = Provider.of<RecursosProvider>(context);
    List<User> products = recurSoProduct.recursoList;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
           Transform.scale(
            scale: 1.2,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
              controller: _pageCoffeController,
              scrollDirection: Axis.vertical,
              itemCount: products.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SizedBox.shrink();
                }
                final result = _currentPage - index + 1;
                final value = -0.9 * result + 1;
                return Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, .01)
                      ..translate(
                          0.0,
                          MediaQuery.of(context).size.height /
                              2.6 *
                              (1 - value).abs())
                      ..scale(value),
                    child: Opacity(
                        opacity: value.clamp(0.0, 1.0),
                        child: Image.network(products[index - 1].image)));
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 100,
            child: Column(
              children: [
                H1( fontSize: 25,
                    text: products[_currentPage.toInt()].nombreCompleto,),
                TextButton(
                    onPressed: () {
                    
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                    currentProduct:
                                        products[_currentPage.toInt()],
                                  )));
                    },
                    child: const Column(
                      children: [
                        Text('Ver detalles'),
                        Icon(Icons.markunread_mailbox)
                      ],
                    ))
              ],
            ),
          ),
         
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailsPage extends StatelessWidget {
  DetailsPage({super.key, required this.currentProduct});
  User currentProduct;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(currentProduct.image),
            ),
            title: Text(currentProduct.nombreCompleto),
            subtitle: Text(currentProduct.role),
          )
        ],
      ),
    );
  }
}
