import 'package:flutter/material.dart';
import 'package:tarefasapp/pages/home_page.dart';
import 'package:tarefasapp/services/app_storage_service.dart';
import 'package:tarefasapp/shared/app_images.dart';
import 'package:tarefasapp/widgets/modal_message.dart';

class UserNamePage extends StatefulWidget {
  const UserNamePage({super.key});

  @override
  State<UserNamePage> createState() => _UserNamePageState();
}

class _UserNamePageState extends State<UserNamePage> {
  final _usernameController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    AppStorageService storage = AppStorageService();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // new Image(image: new AssetImage('/assets/heaven.gif')),
                  children: [
                    Image(
                      image: AssetImage(
                        AppImages.emojiSorrindo,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Como podemos',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      'chamar você?',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0), // 32
                          child: TextField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'digite seu nome',
                            ),
                            controller: _usernameController,
                          )),
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
                        if (_usernameController.text == "" ||
                            _usernameController.text.length <= 2) {
                          var snackBar = const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Informe um nome valido! '),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          storage.setConfiguracoesNomeUsuario(_usernameController.text);
                          await modalMessage(
                              context,
                              'Prontinho',
                              'Agora vamos começar a preparar a lsita de compara para ida ao mercado.',
                              AppImages.emojiOlhosFechados,
                              'Começar'
                              );
                              navegatoToScreen();
                        }
                      },
                      child: const Text(
                        'Confirmar',
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

  void navegatoToScreen() {
    Navigator.of(context).pop();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomePage(username: _usernameController.text)));
  }
}
