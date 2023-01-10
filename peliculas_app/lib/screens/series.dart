import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:peliculas_app/helpers/routes.dart';
import 'package:peliculas_app/models/serie.dart';
import 'package:peliculas_app/providers/series_provider.dart';

import 'package:peliculas_app/screens/screens.dart';
import 'package:peliculas_app/serach/search_delegate.dart';
import 'package:peliculas_app/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:peliculas_app/tokens/tokens.dart';

class SeriesPage extends StatefulWidget {
  @override
  _SeriesPageState createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  late SwiperController swiperController = SwiperController();

  double _opacity = 1;

  @override
  void initState() {
    super.initState();
    swiperController.move(1);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _opacity = 0;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    swiperController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    print('Index: ${swiperController.event}');

    print(_opacity);

    return Scaffold(
        appBar: Header(
          title: 'Series',
          leftContent: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: MyColors.colorIcon, size: 30),
            onPressed: pushNamedAndRemoveUntil('home', context, null),
          ),
          rightContent: GestureDetector(
            onTap: () =>
                showSearch(context: context, delegate: MovieSearchDelegate()),
            child: CircleAvatar(
              backgroundColor: MyColors.colorIcon,
              child: Icon(
                Icons.search_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            PageView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                Page1(),
                Page2(),
                Page3(),
              ],
            ),
            Positioned(
              top: size.height * 0.25,
              left: 0,
              child: AnimatedOpacity(
                curve: Curves.easeInExpo,
                duration: Duration(seconds: 5),
                opacity: _opacity,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(seconds: 5),
                  curve: Curves.easeInExpo,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(value * 500, 0.0),
                      child: child,
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    height: 125,
                    decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Text(
                          'Desliza para ver mas series',
                          style:
                              TextStyle(fontSize: 20, fontFamily: 'CarterOne'),
                        ),
                        Image(
                          image: AssetImage('assets/desliza2.gif'),
                          width: 70,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final seriesProvider = Provider.of<SeriesProvider>(context);
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 0),
              child: SeriesViewContainer(
                  "Populares", seriesProvider.popularSerie)),
        ),
      ],
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final seriesProvider = Provider.of<SeriesProvider>(context);
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 0),
              child: SeriesViewContainer(
                  "Recomendadas", seriesProvider.topRatedSerie)),
        ),
      ],
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final seriesProvider = Provider.of<SeriesProvider>(context);
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 0),
              child: SeriesViewContainerPage2(
                  "Mas Series", seriesProvider.popularSerie2)),
        ),
      ],
    );
  }
}

class SeriesViewContainer extends StatelessWidget {
  final String title;
  final List<Serie> serie;

  const SeriesViewContainer(this.title, this.serie);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final seriesProvider = Provider.of<SeriesProvider>(context);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SeriesView(
          series: serie,
          onNextPage: () => seriesProvider.getPopularSeries(),
        ),
        Container(
          width: size.width * 0.7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 10, offset: Offset(0, 10))
            ],
          ),
          child: Text(
            title,
            style: TextStyle(
                fontFamily: 'CarterOne',
                fontSize: 25,
                color: MyColors.colorIcon),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

class SeriesViewContainerPage2 extends StatelessWidget {
  final String title;
  final List<Serie> serie;

  const SeriesViewContainerPage2(this.title, this.serie);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final seriesProvider = Provider.of<SeriesProvider>(context);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SeriesView(
          series: serie,
          onNextPage: () => seriesProvider.getPopularSeries2(),
        ),
        Container(
          width: size.width * 0.7,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]),
          child: Text(
            title,
            style: TextStyle(
                fontFamily: 'CarterOne',
                fontSize: 25,
                color: MyColors.colorIcon),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
