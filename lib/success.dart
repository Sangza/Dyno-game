import 'dart:ui';

import 'package:dino_run/game/dino_run.dart';
import 'package:dino_run/widgets/game_over_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Success extends StatelessWidget {
  static const id = 'Success';

  final DinoRun gameRef;

  const Success(this.gameRef, {Key? key}) : super(key: key);

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
                        ' Successfully staked your ',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      const Text(
                        ' Avatar ',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      const Text(
                        'APY: 1 stDyno per day',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      const SizedBox(height: 0),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          gameRef.overlays.remove(Success.id);
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
