// ignore_for_file: deprecated_member_use, library_private_types_in_public_api
import 'dart:io';

import 'package:contatoapp/constant.dart';
import 'package:contatoapp/model/contatos_back4app_model.dart';
import 'package:contatoapp/repositories/contato_back4app_repository.dart';
import 'package:contatoapp/services/app_storage_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:contatoapp/pages/contact_page.dart';

class ContactListPage extends StatefulWidget {
  final TabController tabController;
  const ContactListPage({super.key, required this.tabController});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ContactListPage> {
  ContatosBack4AppRepository contatoRepository = ContatosBack4AppRepository();

  var contacts = ContatosBack4AppModel([]);
  AppStorageService storage = AppStorageService();
  bool flagVazio = false;
  String orderBy = "APP_TXT_ORDEM_VALOR_1".tr();
  @override
  void initState() {
    super.initState();
    _obterListaContatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var contato = ContatoModel([]);
          _showContactPage(contact: contato);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      body: contacts.contatos!.isEmpty
          ? Center(
              child: flagVazio
                  ? _mensagemCentro()
                  : const Center(child: CircularProgressIndicator()))
          : Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Como deseja exibir? ',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    DropdownButton<String>(
                      items: <String>[
                        "APP_TXT_ORDEM_VALOR_1".tr(),
                        "APP_TXT_ORDEM_VALOR_2".tr()
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: orderBy,
                      onChanged: (newValue) {
                        sortList(newValue);
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: contacts.contatos?.length,
                    itemBuilder: (context, index) {
                      return _contactCard(context, index);
                    },
                  ),
                )
              ],
            ),
    );
  }

  void sortList(String? newValue) {
    OrderOptions ordem;
    if (newValue == "APP_TXT_ORDEM_VALOR_1".tr()) {
      ordem = OrderOptions.orderaz;
    } else {
      ordem = OrderOptions.orderza;
    }
    setOrdem(ordem);
  }

  Widget _contactCard(BuildContext context, int index) {
    var contato = contacts.contatos?[index];
    return GestureDetector(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: contato?.foto != null
                              ? FileImage(File(contato!.foto.toString()))
                              : const AssetImage("assets/person.png")
                                  as ImageProvider,
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        contato!.nome ?? "",
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${"APP_TXT_TELEFONE".tr()}: ${contato.telefone ?? ""}',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        '${"APP_TXT_DATA_NASCIMENTO".tr()}: ${contato.diaNascimento}/${contato.mesNascimento}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          _showOptions(context, index);
        });
  }

  void _showOptions(BuildContext context, int index) {
    var contato = contacts.contatos?[index];
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 180,
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListView(
              children: <Widget>[
                ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  leading: const Icon(Icons.menu),
                  title: Text(
                    "APP_LABEL_OPC_CONTATOS".tr(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  leading: const Icon(Icons.call),
                  title: Text(
                    "APP_ICO_LIGAR".tr(),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    launch("tel:${contato!.telefone.toString()}");
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  leading: const Icon(Icons.person_add_alt_sharp),
                  title: Text(
                    "APP_ICO_EDITAR".tr(),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pop(context);
                    _showContactPage(contact: contato ?? ContatoModel([]));
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  leading: const Icon(Icons.person_add_disabled_rounded),
                  title: Text(
                    "APP_ICO_EXCLUIR".tr(),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text("APP_ALERT_TITULO_EXCLUIR".tr()),
                        content: Text(
                          "APP_ALERT_MENSAGEM_EXCLUIR".tr(),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(
                                context, "APP_ALERT_BOTAO_NAO".tr()),
                            child: Text("APP_ALERT_BOTAO_NAO".tr()),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(
                                context, "APP_ALERT_BOTAO_SIM".tr()),
                            child: Text("APP_ALERT_BOTAO_SIM".tr()),
                          ),
                        ],
                      ),
                    ).then((returnVal) {
                      if (returnVal != null) {
                        if (returnVal == "APP_ALERT_BOTAO_SIM".tr()) {
                          contatoRepository
                              .deletarContato(contato!.objectId.toString());
                          _obterListaContatos();
                          Navigator.pop(context);
                          setState(() {});
                          debugPrint("returnVal: $returnVal");
                        } else {
                          Navigator.pop(context);
                        }
                      }
                    }).catchError((onError) {
                      debugPrint("returnVal: ERROR");
                    })
                  },
                ),
              ],
            ),
          );
        });
  }

  void _showContactPage({required ContatoModel contact}) async {
    final recContact = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ContactPage(contact: contact)));
    if (recContact != null) {
      if (contact.objectId != "" && contact.objectId != null) {
        await contatoRepository.alterarContato(recContact);
      } else {
        await contatoRepository.inserirContato(recContact);
      }
    }
    _obterListaContatos();
  }

  void _obterListaContatos() {
    contatoRepository.obterContatos().then((list) {
      contacts = list;
      if (list.contatos!.isEmpty) {
        flagVazio = true;
      } else {
        flagVazio = false;
        getOrdem();
        _orderList((orderBy == "APP_TXT_ORDEM_VALOR_1".tr())
            ? OrderOptions.orderaz
            : OrderOptions.orderza);
      }
      if (!mounted) return;
      setState(() {});
    });
  }

  void _orderList(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderaz:
        contacts.contatos?.sort((a, b) {
          return a.nome!.toLowerCase().compareTo(b.nome!.toLowerCase());
        });
        break;
      case OrderOptions.orderza:
        contacts.contatos!.sort((a, b) {
          return b.nome!.toLowerCase().compareTo(a.nome!.toLowerCase());
        });
        break;
      default:
        contacts.contatos?.sort((a, b) {
          return a.nome!.toLowerCase().compareTo(b.nome!.toLowerCase());
        });
    }
    if (!mounted) return;
    setState(() {});
  }

  void setOrdem(OrderOptions result) async {
    switch (result) {
      case OrderOptions.orderaz:
        await storage.setConfiguracoesOrdemLista(0);
        break;
      case OrderOptions.orderza:
        await storage.setConfiguracoesOrdemLista(1);
        break;
      default:
        await storage.setConfiguracoesOrdemLista(0);
        break;
    }
    debugPrint(' _orderList: $result');
    _orderList(result);
    setState(() {});
  }

  Future<void> getOrdem() async {
    var ordemLista = await storage.getConfiguracoesOrdemLista();
    switch (ordemLista) {
      case 0:
        orderBy = "APP_TXT_ORDEM_VALOR_1".tr();
      case 1:
        orderBy = "APP_TXT_ORDEM_VALOR_2".tr();
      default:
        orderBy = "APP_TXT_ORDEM_VALOR_1".tr();
    }
    if (!mounted) return;
    setState(() {});
  }

  Widget _mensagemCentro() {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_search,
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
                "APP_SEM_DADOS_CONTATOS".tr(),
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
