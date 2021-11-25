import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:peliculas_app/customPainters/customs.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/models/video_movie_response.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/screens/screens.dart';
import 'package:peliculas_app/widgets/add_google.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

 BannerAd? bannerDetails;

  @override
  void initState() {
    super.initState();
    bannerDetails = BannerAd(
        size: AdSize(width: 320, height: 60),
        adUnitId: Ads.bannerDetails,
        listener: BannerAdListener(),
        request: AdRequest());
    bannerDetails!.load();
  }


  @override
  Widget build(BuildContext context) {

  final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

  final size = MediaQuery.of(context).size;
    
    return Scaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: [
              //  _CustomAppbar(movie: movie),
                _AppBarDetails(movie),

                Container(
                  margin: EdgeInsets.only(top: size.height * 0.25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                    )
                  ),
                  child: Column(
                    children: [

                          
                    DetailsMovie(movie),

                    ZoomIn(child: ClasPeliculas(movie.genreIds)),

                    _OverView(
                      movie: movie,
                    ),

                    SizedBox(height: 5),


                    SizedBox(height: 10),

                    FadeInRightBig(child: CastingCards(movie.id)),
                    SizedBox(height: 80)

            


                    ],
                  ),
                )

            ],
          ),
          
        ),
        CustomNavigatorBar()
      ],
    ));
  }

  //   Widget bannerAdWidget() {
  //   return StatefulBuilder(
  //     builder: (context, setState) => Container(
  //       child: AdWidget(ad: bannerDetails!),
  //       width: bannerDetails!.size.width.toDouble(),
  //       height: 100.0,
  //       alignment: Alignment.center,
  //     ),
  //   );
  // }

}

class _AppBarDetails extends StatefulWidget {

  final Movie movie;
  const _AppBarDetails(this.movie, );

  @override
  State<_AppBarDetails> createState() => _AppBarDetailsState();
}

class _AppBarDetailsState extends State<_AppBarDetails> {

  // InterstitialAd? interstitialAd;
  // bool isLoaded = false;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   InterstitialAd.load(

  //     adUnitId: Ads.trailer, 
  //     request: AdRequest(), 
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (ad) {
  //         setState(() {
  //           isLoaded = true;
  //           this.interstitialAd=ad;
  //         });

  //         print("Algo fallo al realizar el anuncio");

  //       }, 
  //       onAdFailedToLoad: (error) {

  //         print("Algo fallo al realizar el anuncio");
  //       }
  //       )
      
  //     );
  // }


  @override
  Widget build(BuildContext context) {

final moviesProvider = Provider.of<MoviesProvider>(context);

  
  final size = MediaQuery.of(context).size;
  
    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: Colors.red,
          height: size.height * 0.28,
          child: Stack(
            alignment: Alignment.center,
            children: [


            FadeInImage(
              placeholder: AssetImage('assets/movieLoad.gif'),
              image: NetworkImage(widget.movie.fullBackdropPath),
              fit: BoxFit.cover,
              height: double.infinity,
            ),

            Container(
              color: Colors.black26,
              height: double.infinity,
              width: double.infinity,
            ),

            FutureBuilder(
              future: moviesProvider.getVideoMovie(widget.movie.id),
              builder: ( _, AsyncSnapshot<Video> snapshot ) {

                if (!snapshot.hasData) {
                return Container(
                  
                );
              }

              if (snapshot.data!.id != '000') {

                final Video video = snapshot.data!;


                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 1.0 , end: 0.0),
                        curve: Curves.easeOutBack,
                        duration: Duration(seconds: 1) ,
                        builder: (context , value, child) {
                          return Transform.translate(
                            offset: Offset(value * -200 , 0.0 ),
                            child: child,
                            );
                        },
                        child: GestureDetector(
                          onTap: () {
                              Navigator.pushNamed(context, 'video', arguments: video);
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: MyColors.colorIcon,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: Colors.white, width: 2)),
                            child: Icon(
                              Icons.play_arrow,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );

              }

              return Container();

              }),

           

            ],
          ),
        ),

        Positioned(
    top: 25,
    child: IconButton(
        onPressed: () => Navigator.popAndPushNamed(context, 'home'),
        icon: Icon(
          Icons.reply_rounded,
          color: Colors.white54,
          size: 30,
        ))),
      ],
    );
  }
}

class DetailsMovie extends StatelessWidget {
  final Movie movie;

  const DetailsMovie(this.movie);

  @override
  Widget build(BuildContext context) {
  

    return Padding(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),

              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0 , end: 1.0),
                curve: Curves.easeInOutBack,
                duration: Duration(seconds: 2),
                builder: (context,double value, child ) {
                  return Transform.scale(
                    scale: value,
                    child: child, 
                    );
                },

                child: FadeInImage(
                  placeholder: AssetImage('assets/movieLoad.gif'),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),

              ConstrainedBox(
                constraints: BoxConstraints( maxWidth: 200, minWidth: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5),
                    Text(movie.originalTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle1),
                    SizedBox(
                      height: 5,
                    ),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 15,
                          color: Colors.amber,
                        ),
                        Text('${movie.voteAverage}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption),
                    
                      ],
                    ),
                  ],
                ),
              ),
            // ),
          ],
        ),
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  final Movie movie;

  const _OverView({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return movie.overview.isEmpty
    ? Container()
    : Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      // height: 300,
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(fontFamily: 'AndadaPro', fontSize: 18, color: Colors.grey.shade700),
      ),
    );
  }
}
