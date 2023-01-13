import 'package:flutter/material.dart';
import 'package:peliculas_app/helpers/helpers.dart';
import 'package:peliculas_app/screens/screens.dart';

class RulettePage extends StatelessWidget {
  const RulettePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: Header(
        title: 'Ruleta',
        leftContent: IconButton(
          onPressed: pop(context),
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Center(
          // child: MultiSliver(
          //   // defaults to false
          //   pushPinnedChildren: true,
          //   children: <Widget>[
          //     SliverPinnedHeader(
          //         child: Container(
          //             color: Colors.yellow,
          //             height: 100,
          //             child: Text(
          //               "I am a Pinned Header",
          //               style: TextStyle(fontSize: 30),
          //             ))),
          //     SliverList(
          //       delegate: SliverChildBuilderDelegate(
          //         (BuildContext context, int index) {
          //           return Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Container(
          //               color: index % 2 == 0 ? Colors.green : Colors.greenAccent,
          //               height: 80,
          //               alignment: Alignment.center,
          //               child: Text(
          //                 "Item $index",
          //                 style: const TextStyle(fontSize: 30),
          //               ),
          //             ),
          //           );
          //         },
          //         // 40 list items
          //         childCount: 40,
          //       ),
          //     ),
          //   ],
          // ),
          ),
    );
  }
}
