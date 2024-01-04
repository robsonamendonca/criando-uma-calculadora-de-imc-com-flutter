import 'package:flutter/material.dart';
import 'package:tarefasapp/models/listpurchase_model.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final tabela = []; //ListPurchaseModal.toList();
  List<ListPurchaseModal> selecionadas = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PEGAR ITENS NO MERCADO"),
        actions: const [],
      ),
      body: ListView.builder(
        itemCount: tabela.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final item = tabela[index];
          return CheckboxListTile(
              title: Text(
                item.item!,
              ),
              subtitle: Text(item.categoria!),
              key: Key(item.item!),
              value: item.selected,
              onChanged: (value) {
                setState(() {
                  item.selected = value;
                });
              });
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.extended(
              onPressed: () {
                // Add your onPressed code here!
              },
              label: const Text('Salvar'),
              icon: const Icon(Icons.save),
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton.extended(
              onPressed: () {
                // Add your onPressed code here!
              },
              label: const Text('Enviar'),
              icon: const Icon(Icons.share),
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton.extended(
              onPressed: () {
                // Add your onPressed code here!
              },
              label: const Text('Del.'),
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
