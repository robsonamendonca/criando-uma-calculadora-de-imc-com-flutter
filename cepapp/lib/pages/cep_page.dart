// ignore_for_file: use_build_context_synchronously

import 'package:cepapp/model/ceps_back4app_model.dart';
import 'package:cepapp/model/ceps_viacep_model.dart';
import 'package:cepapp/repositories/cep_back4app_repository.dart';
import 'package:cepapp/repositories/cep_viacep_repository.dart';
import 'package:cepapp/shared/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

class CepPage extends StatefulWidget {
  const CepPage({Key? key}) : super(key: key);

  @override
  State<CepPage> createState() => _CepPageState();
}

class _CepPageState extends State<CepPage> {
  CepsBack4AppRepository cepRepository = CepsBack4AppRepository();
  CepsViaCepRepository cepViaCepRepository = CepsViaCepRepository();
  var _cepsBack4App = CepsBack4AppModel([]);
  var _cepViaCep = CepsViaCepModel();
  var cepController = TextEditingController();
  var carregando = false;

  @override
  void initState() {
    super.initState();
    obterCeps();
  }

  void obterCeps() async {
    setState(() {
      carregando = true;
    });
    _cepsBack4App = (await cepRepository.obterCeps());
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ceps Cadastrados"),
          backgroundColor: Colors.transparent,
          foregroundColor: const Color(0xFF433D82),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 155, 73, 255),
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            cepController.text = "";
            adicionaCEP(context);
          },
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              carregando
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _cepsBack4App.ceps.length,
                        itemBuilder: (BuildContext bc, int index) {
                          var cep = _cepsBack4App.ceps[index];
                          return Dismissible(
                            onDismissed:
                                (DismissDirection dismissDirection) async {
                              await cepRepository
                                  .deletarCep(cep.objectId.toString());
                              obterCeps();
                            },
                            key: Key(cep.objectId.toString()),
                            child: ListTile(
                              title: Text(cep.logradouro.toString()),
                              subtitle: Text(
                                  "${cep.complemento.toString()} - ${cep.bairro.toString()} / ${cep.localidade.toString()}"),
                              isThreeLine: true,
                              leading: Text(cep.uf.toString()),
                              trailing: Text(cep.cep.toString()),
                              onTap: () {
                                alterarCEP(context);
                              },
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ));
  }

  Future<dynamic> adicionaCEP(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext bc) {
          return AlertDialog(
            title: const Text("Adicionar CEP"),
            content: TextField(
              controller: cepController,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar")),
              TextButton(
                  onPressed: () async {
                    var cep =
                        cepController.text.replaceAll(RegExp(r'[^0-9]'), '');
                    if (cep.length == 8) {
                      _cepViaCep = await cepViaCepRepository
                          .obterCep(cepController.text);
                      bool ok = await cepRepository.inserirCep(
                          CepBack4AppModel.inserir(
                              cepController.text,
                              _cepViaCep.logradouro,
                              _cepViaCep.complemento,
                              _cepViaCep.bairro,
                              _cepViaCep.localidade,
                              _cepViaCep.uf,
                              _cepViaCep.ibge,
                              _cepViaCep.gia,
                              _cepViaCep.ddd,
                              _cepViaCep.siafi));
                      if (ok) {
                        Navigator.pop(context);
                        CustomAlertDialog.alertTyoe(
                            "success", "CEP cadastrado com sucesso!", context);
                        obterCeps();
                        setState(() {});
                      } else {
                        CustomAlertDialog.alertTyoe("error",
                            "Erro ao cadsatrar, tente novamente!", context);
                        debugPrint('erro ao inserir');
                      }
                    } else {
                      CustomAlertDialog.alertTyoe(
                          "error", "CEP não foi encontrado!", context);
                      debugPrint('sem dados');
                    }
                  },
                  child: const Text("Salvar"))
            ],
          );
        });
  }

  Future<dynamic> alterarCEP(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext bc) {
          return AlertDialog(
            title: const Text("Alterar CEP"),
            content: Column(
              children: [
                TextField(
                    controller: cepController,
                    decoration: const InputDecoration(label: Text("CEP"))),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Salvar")),
            ],
          );
        });
  }
}
