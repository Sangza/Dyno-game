import 'dart:ui';

import 'package:dino_run/Utils/constant.dart';
import 'package:dino_run/services/function1.dart';
import 'package:dino_run/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '/widgets/hud.dart';
import '/game/dino_run.dart';
import '/widgets/settings_menu.dart';

// This represents the main menu overlay.
class MainMenu extends StatefulWidget {
  static const id = 'MainMenu';

  // Reference to parent game.
  final DinoRun gameRef;

  const MainMenu(this.gameRef, {Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  Client? httpClient;

  Web3Client? maticClient;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    httpClient = Client();
    maticClient = Web3Client(alchemy_url, httpClient!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.black.withAlpha(100),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  const Text(
                    'Dino Run',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await loadcontract();
                    },
                    child: const Text(
                      'Connect',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.gameRef.startGamePlay();
                      widget.gameRef.overlays.remove(MainMenu.id);
                      widget.gameRef.overlays.add(Hud.id);
                    },
                    child: const Text(
                      'Play',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.gameRef.overlays.remove(MainMenu.id);
                      widget.gameRef.overlays.add(SettingsMenu.id);
                    },
                    child: const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.gameRef.overlays.remove(MainMenu.id);
                      widget.gameRef.overlays.add(Hud.id);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: ((context) => Avatar(gameRef))));
                      widget.gameRef.overlays.add(Avatar.id);
                    },
                    child: const Text(
                      'Avatars',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
