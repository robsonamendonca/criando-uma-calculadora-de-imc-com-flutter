// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'dart:io';

import 'package:contatoapp/model/contatos_back4app_model.dart';
import 'package:contatoapp/repositories/contato_back4app_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AniverListPage extends StatefulWidget {
  final TabController tabController;
  const AniverListPage({super.key, required this.tabController});

  @override
  _AniverListPageState createState() => _AniverListPageState();
}

class _AniverListPageState extends State<AniverListPage> {
  var contacts = ContatosBack4AppModel([]);
  ContatosBack4AppRepository contatoRepository = ContatosBack4AppRepository();
  bool flagVazio = true;
  bool carregando = true;
  void _obterListaContatos() {
    carregando = true;
    contatoRepository.obterContatos().then((list) {
      contacts = list;
      flagVazio = (list.contatos!.isEmpty);
      carregando = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _obterListaContatos();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    List<ContatoModel> aniversariantesDoDia = [];
    if (contacts.contatos!.isNotEmpty) {
      NumberFormat formatter = NumberFormat("00");
      aniversariantesDoDia = contacts.contatos!.where((item) {
        final dataNascimento = DateTime.parse(
          '${today.year}-${formatter.format(item.mesNascimento)}-${formatter.format(item.diaNascimento)}',
        );
        return dataNascimento.month == today.month &&
            dataNascimento.day == today.day;
      }).toList();

      setState(() {
        flagVazio = aniversariantesDoDia.isEmpty;
      });
    }
    String removeChars(String input) {
      return input.replaceAll(RegExp(r'[()\-\s]'), '');
    }

    return Scaffold(
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : flagVazio
              ? Center(child: _mensagemCentro())
              : ListView.builder(
                  itemCount: aniversariantesDoDia.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = aniversariantesDoDia[index];
                    return Card(
                      child: ListTile(
                        leading: Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: item.foto != null
                                      ? FileImage(File(item.foto.toString()))
                                      : const AssetImage("assets/person.png")
                                          as ImageProvider,
                                  fit: BoxFit.cover)),
                        ),
                        title: Text(item.nome.toString()),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${"APP_TXT_TELEFONE".tr()}: ${item.telefone}'),
                            Text(
                                '${"APP_TXT_DATA_NASCIMENTO".tr()}: ${item.diaNascimento}/${item.mesNascimento}'),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          itemBuilder: (context) {
                            return [
                              "APP_TXT_FAZER_LIGACAO".tr(),
                              "APP_TXT_FALAR_ZAP".tr()
                            ].map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                          onSelected: (String choice) {
                            // Implemente as ações do menu pop-up aqui.
                            if (choice == "APP_TXT_FAZER_LIGACAO".tr()) {
                              launch("tel:${item.telefone.toString()}");
                            } else if (choice == "APP_TXT_FALAR_ZAP".tr()) {
                              launch(
                                  "https://api.whatsapp.com/send?phone=55${removeChars(item.telefone.toString())}&text=${"APP_TXT_FELIZ_ANIVER".tr()}");
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _mensagemCentro() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.free_breakfast_sharp,
                size: 100, // 160
                color: Colors.grey,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "APP_TXT_SEM_DADOS_ANIVER".tr(),
                style: const TextStyle(color: Colors.grey, fontSize: 18.0),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
