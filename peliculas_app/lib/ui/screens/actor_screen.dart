import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../peliculas_app.dart';

class ActorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Cast person = ModalRoute.of(context)!.settings.arguments as Cast;
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: MyColors.grey3,
            )),
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
          future: moviesProvider.getActoresMovie(person.id),
          builder: (_, AsyncSnapshot<PersonResponse> snapshot) {
            if (snapshot.hasError) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Text(
                    'No hay información',
                    style: TextStyle(fontSize: 25, fontFamily: 'CarterOne'),
                  ),
                ),
              );
            }
            if (!snapshot.hasData) {
              return Container(
                width: double.infinity,
                height: 200,
                child: CupertinoActivityIndicator(
                  radius: 30,
                ),
              );
            }

            PersonResponse personResponse = snapshot.data!;

            final size = MediaQuery.of(context).size;

            return Builder(
              builder: (context) => Container(
                color: MyColors.grey2,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _TopDetalles(
                          size: size,
                          person: person,
                          personResponse: personResponse),
                      _BotDetalles(personResponse: personResponse),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class _BotDetalles extends StatelessWidget {
  const _BotDetalles({
    Key? key,
    required this.personResponse,
  }) : super(key: key);

  final PersonResponse personResponse;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                _DatosPersona(
                    titulo: 'Lugar de Nacimiento',
                    texto: Text(
                      '${personResponse.placeOfBirth}',
                      style: TextStyle(color: MyColors.white, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    color1: MyColors.red,
                    color2: MyColors.orange,
                    icon: Icons.home,
                    personResponse: personResponse),
                SizedBox(height: 20),
                _DatosPersona(
                    titulo: 'Fecha de Nacimiento',
                    texto: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 5),
                        Text('${personResponse.birthday!.day}',
                            style:
                                TextStyle(color: MyColors.white, fontSize: 25)),
                        Text(' / ${personResponse.birthday!.month}',
                            style:
                                TextStyle(color: MyColors.white, fontSize: 25)),
                        Text(' / ${personResponse.birthday!.year}',
                            style:
                                TextStyle(color: MyColors.white, fontSize: 25)),
                      ],
                    ),
                    color1: MyColors.blue,
                    color2: MyColors.purple,
                    icon: Icons.date_range_outlined,
                    personResponse: personResponse),
                SizedBox(height: 20),
              ],
            ),
          ),
          FadeInUp(
            child: Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: MyColors.white),
                child: Text(personResponse.biography!,
                    style: TextStyle(), textAlign: TextAlign.justify)),
          ),
        ],
      ),
    );
  }
}

class _DatosPersona extends StatelessWidget {
  const _DatosPersona({
    Key? key,
    required this.personResponse,
    required this.titulo,
    required this.color1,
    required this.color2,
    required this.icon,
    required this.texto,
  }) : super(key: key);

  final PersonResponse personResponse;
  final String titulo;
  final Widget texto;
  final Color color1;
  final Color color2;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElasticIn(
      duration: Duration(seconds: 2),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(colors: [color1, color2])),
            child: Column(
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      color: MyColors.grey3,
                      fontSize: 15),
                ),
                Container(child: texto),
              ],
            ),
          ),
          Positioned(
            right: -25,
            child: Transform.rotate(
                angle: -0.2,
                child: Icon(
                  icon,
                  color: Colors.white24,
                  size: 80,
                )),
          ),
        ],
      ),
    );
  }
}

class _TopDetalles extends StatelessWidget {
  const _TopDetalles({
    Key? key,
    required this.size,
    required this.person,
    required this.personResponse,
  }) : super(key: key);

  final Size size;
  final Cast person;
  final PersonResponse personResponse;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.6,
      child: Stack(
        children: [
          FadeInImage(
            placeholder: AssetImage('assets/movieLoad.gif'),
            image: NetworkImage(person.fullprofilePath),
            height: size.height * 0.55,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              height: 80,
              padding: EdgeInsets.all(10),
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    personResponse.name,
                    style: TextStyle(fontSize: 25, fontFamily: 'CarterOne'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
