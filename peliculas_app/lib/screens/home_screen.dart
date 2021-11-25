import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:peliculas_app/customPainters/customs.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/screens/screens.dart';
import 'package:peliculas_app/widgets/add_google.dart';
import 'package:peliculas_app/widgets/myColors.dart';

// import 'package:peliculas_app/widgets/add_google.dart';

import 'package:peliculas_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

  ScrollController controller = ScrollController();
  bool mostrarAnimacion1 =  false;
  bool mostrarAnimacion2 = false;
  // BannerAd? bannerAd;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {

      print(controller.offset);

      setState(() {
        if (controller.offset > 205.0) {
          mostrarAnimacion1 = true;
        } 
        if (controller.offset > 520.0) {
          mostrarAnimacion2 = true;
        } 

      });
     
      
    });
    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }
    // bannerAd = BannerAd (
    //   size: AdSize(width: 320 , height: 60 ), 
    //   adUnitId: Ads.bannerHome, 
    //   listener: BannerAdListener(), 
    //   request: AdRequest()
    //   );
    // bannerAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    
    final moviesProvider = Provider.of<MoviesProvider>(context);



    super.build(context);
    return WillPopScope(
      onWillPop: () async => false ,
      child: Scaffold(
        appBar: myAppbar(context, "Peliculas", null ),
        body: Stack(
          children: [
          // AdWidget(ad: myBanner),
    
            SingleChildScrollView(
              controller: controller,
              physics: BouncingScrollPhysics(),
              child: Stack(
                children: [
                  SafeArea(
                    child: Column(  
                      children: [
           
                        SizedBox(height: 5),
    
                        degrade(context),
                        CardSwiper(movies: moviesProvider.onDisplayMovie),
                        Container(
                          width: double.infinity,
                          height: 25,
                          // color: Colors.red,
                          child: CustomPaint(
                            painter: CustomDecoration(),
                          ),
                        ),

                        MovieSlider(
                          onNextPage: () => moviesProvider.getUpcomingMovies(),
                          movies: moviesProvider.upcomingMovies,
                          title: 'Recientes',
                        ),

                        ElasticIn(
                          duration: Duration(seconds: 2),
                          animate: mostrarAnimacion1,
                          child: _BotonInicio('Trailers', () => Navigator.pushNamed(context, 'trailers'))),

                        MovieSlider(
                          movies: moviesProvider.popularMovies,
                          onNextPage: () => moviesProvider.getPopularMovies(),
                          title: 'Populares',
                        ),
    
                        BounceInRight(
                          animate: mostrarAnimacion2,
                          child: _BotonInicio('Series', () => Navigator.pushNamed(context, 'series'))),

    
                        MovieSlider(
                          onNextPage: () => moviesProvider.getTopRatioMovies(),
                          movies: moviesProvider.topRateMovies,
                          title: 'Mas valorados',
                        ),
    
                        SizedBox(
                          height: 75,
                        ),
    
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CustomNavigatorBar()
          ],
        ),
      ),
    );
  }

  // Widget bannerAdWidget() {
  //   return StatefulBuilder(
  //     builder: (context, setState) => Container(
  //       child: AdWidget(ad: bannerAd!),
  //       width: bannerAd!.size.width.toDouble(),
  //       height: 100.0,
  //       alignment: Alignment.center,
  //     ),
  //   );
  // }

  @override
  bool get wantKeepAlive => true;
}

class _BotonInicio extends StatelessWidget {

  final String texto;
  final VoidCallback onTap;

  const _BotonInicio( this.texto, this.onTap);

  @override
  Widget build(BuildContext context) {
    return
    
    
     GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
        color: MyColors.colorIcon,
        borderRadius: BorderRadius.all(Radius.circular(16))
        ),
    
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(texto, style: TextStyle(fontSize: 35, fontFamily: 'CarterOne', color: Colors.white),),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Icon(Icons.arrow_forward_ios_rounded, color: MyColors.colorIcon,),
            )
          ],
        ),
      ),
    );
  }
}


