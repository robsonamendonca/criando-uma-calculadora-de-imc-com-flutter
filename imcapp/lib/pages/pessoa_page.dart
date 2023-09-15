// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:imcapp/model/pessoa.dart';
import 'package:imcapp/repositories/pessoa_repository.dart';

class PessoaPage extends StatefulWidget {
  const PessoaPage({super.key});

  @override
  State<PessoaPage> createState() => _PessoaPageState();
}

class _PessoaPageState extends State<PessoaPage> {
  final _formKey = GlobalKey<FormState>();

  var pessoaRepository = PessoaRepository();
  var _pessoas = const <Pessoa>[];
  var alturaController = TextEditingController();
  var pesoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    obterPessoas();
  }

  void obterPessoas() async {
    _pessoas = await pessoaRepository.listar();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Controle de IMC'),
          elevation: 2.0,
          centerTitle: true,
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
                              key: Key(pessoa.id),
                              child: ListTile(
                                title: Text(
                                    "Altura: ${pessoa.altura.toString()} - Peso: ${pessoa.peso.toString()} "),
                                subtitle: Text(pessoa.classificaoImc),
                                trailing: Text(pessoa.data),
                                isThreeLine: true,
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
                            controller: alturaController,
                            decoration: const InputDecoration(
                                hintText: "Informe sua altura (1,70) metros"),
                          ),
                        ),
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
                                await pessoaRepository.adicionar(Pessoa(
                                    double.parse(pesoController.text),
                                    double.parse(alturaController.text)));
                                Navigator.pop(context);
                                pesoController.text = "";
                                alturaController.text = "";
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
