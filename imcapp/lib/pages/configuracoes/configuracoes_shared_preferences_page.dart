// ignore_for_file: avoid_unnecessary_containers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:imcapp/services/app_storage_service.dart';

class ConfiguracoesSharedPreferencesPage extends StatefulWidget {
  const ConfiguracoesSharedPreferencesPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracoesSharedPreferencesPage> createState() =>
      _ConfiguracoesSharedPreferencesPageState();
}

class _ConfiguracoesSharedPreferencesPageState
    extends State<ConfiguracoesSharedPreferencesPage> {
  AppStorageService storage = AppStorageService();

  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String? nomeUsuario;
  double? altura;
  bool receberNotificacoes = false;
  bool temaEscuro = false;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    nomeUsuarioController.text = await storage.getConfiguracoesNomeUsuario();
    alturaController.text =
        (await (storage.getConfiguracoesAltura())).toString();
    receberNotificacoes = await storage.getConfiguracoesReceberNotificacao();
    temaEscuro = await storage.getConfiguracoesTemaEscuro();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text("Configurações")),
            body: Container(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: const InputDecoration(hintText: "Nome usuário"),
                      controller: nomeUsuarioController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: "Altura"),
                      controller: alturaController,
                    ),
                  ),
                  SwitchListTile(
                    title: const Text("Receber notificações"),
                    onChanged: (bool value) {
                      setState(() {
                        receberNotificacoes = value;
                      });
                    },
                    value: receberNotificacoes,
                  ),
                  SwitchListTile(
                      title: const Text("Tema escuro"),
                      value: temaEscuro,
                      onChanged: (bool value) {
                        setState(() {
                          temaEscuro = value;
                        });
                      }),
                  TextButton(
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        try {
                          await storage.setConfiguracoesAltura(
                              double.parse(alturaController.text));
                        } catch (e) {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: const Text("Meu App"),
                                  content:
                                      const Text("Favor informar uma altura válida!"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Ok"))
                                  ],
                                );
                              });
                          return;
                        }
                        await storage.setConfiguracoesNomeUsuario(
                            nomeUsuarioController.text);
                        await storage.setConfiguracoesReceberNotificacao(
                            receberNotificacoes);
                        await storage.setConfiguracoesTemaEscuro(temaEscuro);
                        Navigator.pop(context);
                      },
                      child: const Text("Salvar"))
                ],
              ),
            )));
  }
}