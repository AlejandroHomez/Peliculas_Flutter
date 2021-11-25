import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/models/serie.dart';
import 'package:peliculas_app/models/video_movie_response.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import "dart:async";

import 'package:peliculas_app/screens/screens.dart';
import 'package:provider/provider.dart';

class SeriesView extends StatefulWidget {
  final Function onNextPage;
  final List<Serie> series;

  const SeriesView({Key? key, required this.onNextPage, required this.series})
      : super(key: key);

  @override
  _SeriesViewState createState() => _SeriesViewState();
}

class _SeriesViewState extends State<SeriesView> {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    this.widget.onNextPage;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(top: 15),
          width: size.width,
          height: size.height,
          child: Stack(
          children: [
            Swiper(
              scrollDirection: Axis.vertical,
              layout: SwiperLayout.DEFAULT,
              curve: Curves.easeInOutBack,
              scale: 0.5,
              itemCount: widget.series.length,
              itemWidth: size.width * 0.5,
              itemHeight: size.height * 0.5,

              pagination: SwiperPagination(
                  alignment: Alignment.topRight,
                  builder: FractionPaginationBuilder(
                      color: Colors.white30,
                      activeColor: MyColors.colorIcon,
                      fontSize: 15,
                      activeFontSize: 20),
                  margin: EdgeInsets.all(20)),
              itemBuilder: (_, int index) => SliderSeries(widget.series[index]),
            ),
          ]),
        ),
      ],
    );
  }
}

class SliderSeries extends StatefulWidget {
  final Serie serie;
  const SliderSeries(this.serie);

  @override
  _SliderSeriesState createState() => _SliderSeriesState();
}

class _SliderSeriesState extends State<SliderSeries> {
  bool selected = true;
  double? height;
  int? lines = 4;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 5),
      alignment: Alignment.center,
      width: size.width,
      height: 600,
      child: Stack(alignment: Alignment.bottomCenter, children: [
        Column(
          children: [
            FadeInImage(
              placeholder: AssetImage('assets/movieLoad.gif'),
              image: NetworkImage(widget.serie.fullPosterImgSerie),
              // height: 540,
              width: size.width,
              fit: BoxFit.contain,
            ),
          ],
        ),

        GestureDetector(
          onTap: () {
            setState(() {
              lines = 4;
              selected = !selected;
              if (!selected)
                Future.delayed(const Duration(seconds: 1), () {
                  setState(() {
                    lines = 30;
                  });
                });
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 600),
            curve: Curves.easeInOutBack,
            padding: EdgeInsets.only(top: 5, right: 8, left: 8, bottom: 15),
            width: size.width,
            height: selected ? 250 : 380,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, spreadRadius: 10, blurRadius: 10)
                ]),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    widget.serie.name,
                    style: TextStyle(fontSize: 35, fontFamily: 'CarterOne'),
                  ),
                  Text(
                    widget.serie.overview,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w200,
                        fontFamily: 'AndadaPro'),
                    maxLines: selected ? 4 : lines,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Container(
                          margin: EdgeInsets.only(top: 20, right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage(
                              placeholder: AssetImage('assets/movieLoad.gif'),
                              image: NetworkImage(
                                  widget.serie.fullBackdropPathSerie),
                              height: 80,
                              fit: BoxFit.contain,
                            ),
                          )
                      ),

                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: size.width - 205),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.serie.originalName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Calificacion: ",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Text(
                                    '${widget.serie.voteAverage}',
                                    style: TextStyle(
                                        color: Colors.cyan.shade600,
                                        fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "          Votos: ",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Text(
                                    '${widget.serie.voteCount}',
                                    style: TextStyle(
                                        color: Colors.cyan.shade600,
                                        fontSize: 18),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 100)
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

