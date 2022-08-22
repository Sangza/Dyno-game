// Expanded(
//               child: CarouselSlider(
//             options: CarouselOptions(height: 400.0),
//             items: [
//               Icon(
//                 MdiIcons.humanMale,
//                 size: 50,
//               ),
//               Icon(
//                 MdiIcons.humanFemale,
//                 size: 50,
//               ),
//               Icon(
//                 MdiIcons.octahedron,
//                 size: 50,
//               )
//             ].map((i) {
//               return Builder(
//                 builder: (BuildContext context) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                             width: 200,
//                             height: 300,
//                             margin: EdgeInsets.symmetric(horizontal: 5.0),
//                             decoration: BoxDecoration(color: Colors.amber),
//                             child: i),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Text("Select Gender")
//                       ],
//                     ),
//                   );
//                 },
//               );
//             }).toList(),
//           ))

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dino_run/Utils/constant.dart';
import 'package:dino_run/game/dino_run.dart';
import 'package:dino_run/services/function1.dart';
import 'package:dino_run/services/function2.dart';
import 'package:dino_run/widgets/main_menu.dart';
import 'package:dino_run/widgets/settings_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

class Avatar extends StatefulWidget {
  static const id = 'Avatar';

  // Reference to parent game.
  final DinoRun gameRef;

  const Avatar(
    this.gameRef, {
    Key? key,
  }) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  Client? httpClient;

  Web3Client? maticClient;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.gameRef.settings,
      child: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.black.withAlpha(100),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          await mint(1, maticClient!);
                        },
                        child: const Text('Mint'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'price',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          child: CarouselSlider(
                        options: CarouselOptions(height: 400.0),
                        items: [
                          Image.asset('assets/images/extra/Idle (1).png'),
                          Image.asset('assets/images/extra/Idle (4).png'),
                          Image.asset('assets/images/extra/Idle (1).png'),
                          Image.asset('assets/images/extra/Idle (9).png'),
                        ].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 200,
                                        height: 220,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration:
                                            BoxDecoration(color: Colors.amber),
                                        child: i),
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
                      )),
                      TextButton(
                          onPressed: () async {
                            await bid(1, 1, maticClient!);
                          },
                          child: const Text('Bid')),
                      const SizedBox(height: 0),
                      TextButton(
                        onPressed: () {
                          // Navigator.of(context).pop();
                          widget.gameRef.overlays.remove(Avatar.id);
                          widget.gameRef.overlays.add(MainMenu.id);
                        },
                        child: const Icon(Icons.arrow_back_ios_rounded),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
