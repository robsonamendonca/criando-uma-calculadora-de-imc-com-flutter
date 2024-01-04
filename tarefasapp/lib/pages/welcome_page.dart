// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tarefasapp/pages/home_page.dart';
import 'package:tarefasapp/pages/username_page.dart';
import 'package:tarefasapp/services/app_storage_service.dart';

class WelcomPage extends StatefulWidget {
  const WelcomPage({super.key});

  @override
  State<WelcomPage> createState() => _WelcomPageState();
}

class _WelcomPageState extends State<WelcomPage> {
  AppStorageService storage = AppStorageService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Gerencie',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      'suas listas de compras',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      'de mercado de uma',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      'forma fácil',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // new Image(image: new AssetImage('/assets/heaven.gif')),
                  children: [
                    Image(
                      image: AssetImage(
                        "lib/assets/seleciona-item.gif",
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16.0), // 32
                        child: Text(
                          'Lista de compras com checklist para lembrar o que pega no mercado.',
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Container(
                  height: 40, // 40
                  alignment: Alignment.centerLeft,
                  child: SizedBox.expand(
                    // width: 200,
                    child: ElevatedButton(
                      onPressed: () async {
                        var username = await storage.getConfiguracoesNomeUsuario();
                        if (username.toString() != "") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        username: username,
                                      )));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserNamePage()));
                        }
                      },
                      child: const Text(
                        'Continuar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color.fromARGB(255, 7, 2, 88),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
