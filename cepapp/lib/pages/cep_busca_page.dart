// ignore_for_file: use_build_context_synchronously

import 'package:cepapp/model/ceps_back4app_model.dart';
import 'package:cepapp/pages/cep_page.dart';
import 'package:cepapp/repositories/cep_back4app_repository.dart';
import 'package:cepapp/shared/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

import 'package:cepapp/model/ceps_viacep_model.dart';
import 'package:cepapp/repositories/cep_viacep_repository.dart';

class CepBuscaPage extends StatefulWidget {
  const CepBuscaPage({Key? key}) : super(key: key);

  @override
  State<CepBuscaPage> createState() => _CepBuscaPageState();
}

class _CepBuscaPageState extends State<CepBuscaPage> {
  var cepController = TextEditingController(text: "");
  bool loading = false;
  var viacepModel = CepsViaCepModel();
  var viaCEPRepository = CepsViaCepRepository();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("CEP Consultas"),
          backgroundColor: Colors.transparent,
          foregroundColor: const Color(0xFF433D82),
          elevation: 0,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Informe o CEP",
                    style: TextStyle(
                      fontSize: 22,
                      backgroundColor: Colors.transparent,
                      color: Color(0xFF433D82),
                    ),
                  ),
                  TextField(
                    controller: cepController,
                    keyboardType: TextInputType.number,
                    //maxLength: 8,
                    onChanged: (String value) async {
                      var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
                      if (cep.length == 8) {
                        setState(() {
                          loading = true;
                        });
                        viacepModel = await viaCEPRepository.obterCep(cep);
                        if (viacepModel.cep == null) {
                          CustomAlertDialog.alertTyoe("error",
                              "CEP não existe, tente novamente", context);
                        }
                      }
                      setState(() {
                        loading = false;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    viacepModel.logradouro ?? "",
                    style: const TextStyle(fontSize: 22),
                  ),
                  Text(
                    "${viacepModel.complemento ?? ""}  ${viacepModel.bairro ?? ""}",
                    style: const TextStyle(fontSize: 22),
                  ),
                  Text(
                    "${viacepModel.cep ?? ""}  ${viacepModel.localidade ?? ""}  ${viacepModel.uf ?? ""}",
                    style: const TextStyle(fontSize: 22),
                  ),
                  viacepModel.cep != null
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            TextButton.icon(
                                onPressed: salvarCep,
                                icon:
                                    const Icon(Icons.save, color: Colors.blue),
                                label: const Text(
                                  "Salvar CEP",
                                  style: TextStyle(fontSize: 14),
                                )),
                          ],
                        )
                      : Container(),
                  if (loading) const CircularProgressIndicator(),
                ],
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomRight,
              child: _buildAddButton(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(25.0)),
      child: MaterialButton(
        height: 55.0,
        minWidth: 55.0,
        color: const Color.fromARGB(255, 155, 73, 255),
        onPressed: () {
          obterCeps();
        },
        child: const Icon(Icons.menu, color: Colors.white),
      ),
    );
  }

  void salvarCep() async {
    var cepRepository = CepsBack4AppRepository();
    bool ok = await cepRepository.inserirCep(CepBack4AppModel.inserir(
        "",
        cepController.text,
        viacepModel.logradouro,
        viacepModel.complemento,
        viacepModel.bairro,
        viacepModel.localidade,
        viacepModel.uf,
        viacepModel.ibge,
        viacepModel.gia,
        viacepModel.ddd,
        viacepModel.siafi));
    if (ok) {
      CustomAlertDialog.alertTyoe(
          "success", "CEP cadastrado com sucesso!", context);
      obterCeps();
    } else {
      CustomAlertDialog.alertTyoe(
          "error", "Erro ao cadsatrar, tente novamente!", context);
      debugPrint('erro ao inserir');
    }
  }

  void obterCeps() {
    Navigator.pop(context, true);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CepPage()));
  }
}
