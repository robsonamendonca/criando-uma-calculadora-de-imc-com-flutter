import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarefasapp/pages/home_page.dart';
import 'package:tarefasapp/pages/welcome_page.dart';
import 'package:tarefasapp/services/app_storage_service.dart';
import 'package:tarefasapp/services/dark_mode_service.dart';
import 'package:tarefasapp/shared/app_images.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  AppStorageService storage = AppStorageService();
  TextEditingController nomeUsuarioController = TextEditingController();

  String? nomeUsuario;
  bool exibirContador = false;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    nomeUsuarioController.text = await storage.getConfiguracoesNomeUsuario();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Opções")),
        body: Container(
          width: MediaQuery.of(context).size.width - 10,
          height: MediaQuery.of(context).size.height - 80,
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: ListView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 48,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // new Image(image: new AssetImage('/assets/heaven.gif')),
                  children: [
                    Image(
                      image: AssetImage(
                        AppImages.emojiOlhosFechados,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: const InputDecoration(hintText: 'Informe seu nome'),
                controller: nomeUsuarioController,
              ),
            ),
            TextButton(
              onPressed: () async {
                if (nomeUsuarioController.text == "" ||
                    nomeUsuarioController.text.length <= 2) {
                  var snackBar = const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Informe um nome valido! '),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  await storage
                      .setConfiguracoesNomeUsuario(nomeUsuarioController.text);
                  navegatoToScreen();
                }
              },
              child: const Text("Salvar alteração"),
            ),
            const Divider(),
            const Center(child: Text("Dark Mode")),
            Consumer<DarkModeService>(builder: (_, darkModeService, widget) {
              return Switch(
                  value: darkModeService.darkMode,
                  onChanged: (bool value) {
                    darkModeService.darkMode = !darkModeService.darkMode;
                  });
            }),
            const Divider(),
            TextButton(
                onPressed: () async {
                  await storage.setConfiguracoesNomeUsuario("");
                  navegatoToStart();
                },
                child: const Text('Reinicar App'))
          ]),
        ),
      ),
    );
  }

  void navegatoToScreen() {
    Navigator.of(context).pop();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomePage(username: nomeUsuarioController.text)));
  }

  void navegatoToStart() {
    Navigator.of(context).pop();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const WelcomPage()));
  }
}
