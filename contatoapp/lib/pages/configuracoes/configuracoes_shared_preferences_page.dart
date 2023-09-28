// ignore_for_file: avoid_unnecessary_containers, use_build_context_synchronously

import 'package:contatoapp/pages/home_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:contatoapp/services/app_storage_service.dart';

class ConfiguracoesSharedPreferencesPage extends StatefulWidget {
  final TabController tabController;
  const ConfiguracoesSharedPreferencesPage(
      {Key? key, required this.tabController})
      : super(key: key);

  @override
  State<ConfiguracoesSharedPreferencesPage> createState() =>
      _ConfiguracoesSharedPreferencesPageState();
}

class _ConfiguracoesSharedPreferencesPageState
    extends State<ConfiguracoesSharedPreferencesPage> {
  AppStorageService storage = AppStorageService();

  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController emailUsuarioController = TextEditingController();

  String? nomeUsuario;
  String? emailUsuario;
  String? idioma;
  bool exibirContador = false;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    nomeUsuarioController.text = await storage.getConfiguracoesNomeUsuario();
    emailUsuarioController.text =
        (await (storage.getConfiguracoesEmailUsuario())).toString();
    idioma = await storage.getConfiguracoesIdioma();
    exibirContador = await storage.getConfiguracoesExibirContador();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            //appBar: AppBar(title: const Text("Configurações")),
            body: Container(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration:
                  InputDecoration(hintText: "APP_LABEL_NOME_USUARIO".tr()),
              controller: nomeUsuarioController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(hintText: "APP_LABEL_EMAIL_USUARIO".tr()),
              controller: emailUsuarioController,
            ),
          ),
          SwitchListTile(
            title: Text("APP_LABEL_IDIOMA_PT".tr()),
            onChanged: (bool ativo) {
              setState(() {
                idioma = (ativo) ? "pt_BR" : "en_US";
              });
            },
            value: (idioma == "pt_BR" ? true : false),
          ),
          SwitchListTile(
            title: Text("APP_LABEL_EXIBIR_CONTADOR".tr()),
            onChanged: (bool value) {
              setState(() {
                exibirContador = value;
              });
            },
            value: exibirContador,
          ),
          TextButton(
              onPressed: () async {
                //FocusManager.instance.primaryFocus?.unfocus();
                await storage
                    .setConfiguracoesNomeUsuario(nomeUsuarioController.text);
                await storage
                    .setConfiguracoesEmailUsuario(emailUsuarioController.text);
                await storage.setConfiguracoesIdioma(idioma.toString());
                await storage.setConfiguracoesExibirContador(exibirContador);
                if (idioma == "pt_BR") {
                  EasyLocalization.of(context)!
                      .setLocale(const Locale('pt', 'BR'));
                } else {
                  EasyLocalization.of(context)!
                      .setLocale(const Locale('en', 'US'));
                }
                //widget.tabController.animateTo(0);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: Text("APP_BOTAO_SALVAR".tr()))
        ],
      ),
    )));
  }
}
