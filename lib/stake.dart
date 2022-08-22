import 'dart:ui';

import 'package:dino_run/game/dino_run.dart';
import 'package:dino_run/services/function4.dart';
import 'package:dino_run/success.dart';
import 'package:dino_run/widgets/game_over_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

class Stake extends StatelessWidget {
  static const id = 'Stake';

  final DinoRun gameRef;

  Stake(this.gameRef, {Key? key}) : super(key: key);

  Client? httpClient;

  Web3Client? maticClient;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: gameRef.settings,
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
                      const Text(
                        'Stake your Avatar for stDyno',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                          onPressed: () async {
                            // await stake(1, maticClient!);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Success(gameRef))));

                            Dialog(
                              child: Text(
                                  'you have successfully staked your Avatar'),
                            );
                          },
                          child: Text('Stake')),
                      const SizedBox(height: 0),
                      TextButton(
                        onPressed: () {
                          gameRef.overlays.remove(Stake.id);
                          gameRef.overlays.add(GameOverMenu.id);
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
