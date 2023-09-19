// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:imcapp/model/pessoa_sqlite_model.dart';
import 'package:imcapp/pages/configuracoes/configuracoes_shared_preferences_page.dart';
import 'package:imcapp/repositories/pessoa_sqllite_repository.dart';
import 'package:imcapp/services/app_storage_service.dart';

class PessoaPage extends StatefulWidget {
  const PessoaPage({super.key});

  @override
  State<PessoaPage> createState() => _PessoaPageState();
}

class _PessoaPageState extends State<PessoaPage> {
  final _formKey = GlobalKey<FormState>();

  AppStorageService storage = AppStorageService();

  var pessoaRepository = PessoaSQLiteRepository();
  var _pessoas = const <PessoaSQLiteModel>[];
  var alturaController = TextEditingController();
  var pesoController = TextEditingController();
  int id = 0;
  String classificacao = "";
  double imc = 0;
  String nome = "";

  @override
  void initState() {
    super.initState();
    obterPessoas();
  }

  void obterPessoas() async {
    _pessoas = await pessoaRepository.obterDados();
    alturaController.text =
        (await (storage.getConfiguracoesAltura())).toString();
    nome = (await storage.getConfiguracoesNomeUsuario()).toString();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Controle de IMC'),
          elevation: 2.0,
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              color: Colors.black,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ConfiguracoesSharedPreferencesPage(),
                    ));
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            frmDados();
          },
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              _pessoas.isEmpty
                  ? const Text(
                      "Use o botão '+' para iniciar seu controle!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: _pessoas.length,
                          itemBuilder: (BuildContext bc, int index) {
                            var pessoa = _pessoas[index];
                            return Dismissible(
                              onDismissed:
                                  (DismissDirection dismissDirection) async {
                                await pessoaRepository.remover(pessoa.id);
                                obterPessoas();
                              },
                              key: Key(pessoa.id.toString()),
                              child: ListTile(
                                title: Text(
                                    "Altura: ${pessoa.altura.toString()} - Peso: ${pessoa.peso.toString()} "),
                                subtitle: Text(pessoa.classificacaoImc),
                                trailing: Text(pessoa.data),
                                isThreeLine: true,
                                onTap: () {
                                  id = pessoa.id;
                                  pesoController.text = pessoa.peso.toString();
                                  setState(() {});
                                  frmDados();
                                },
                              ),
                            );
                          }),
                    ),
            ],
          ),
        ));
  }

  void frmDados() async {
    await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
              content: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned(
                    right: -40,
                    top: -40,
                    child: InkResponse(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: pesoController,
                            decoration: const InputDecoration(
                                hintText: "Informe seu peso  (75) kilos"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            child: const Text('Salvar'),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await pessoaRepository.salvar(PessoaSQLiteModel(
                                  id,
                                  nome,
                                  double.parse(pesoController.text),
                                  double.parse(alturaController.text),
                                ));
                                obterPessoas();
                                Navigator.pop(context);
                                pesoController.text = "";
                                setState(() {});
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
