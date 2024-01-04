// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:tarefasapp/models/listpurchase_model.dart';
import 'package:tarefasapp/shared/app_colors.dart';

class SelectPage extends StatefulWidget {
  final String title;
  const SelectPage({Key? key, required this.title}) : super(key: key);

  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  final tabela =[]; //ListPurchaseModal;
  List<ListPurchaseModal> selecionadas = [];

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: Text(widget.title),
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
        ),
        title: Text('${selecionadas.length} selecionados'),
        backgroundColor: Colors.blueGrey[50],
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int idx) {
          return ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            leading: (selecionadas.contains(tabela[idx]))
                ? const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.check),
                  )
                : const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.check_box_outline_blank_outlined),
                  ),
            title: Text(
              tabela[idx].item!,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(
              tabela[idx].categoria!,
              style: const TextStyle(fontSize: 15),
            ),
            selected: selecionadas.contains(tabela[idx]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {},
            onTap: () => {
              setState(() {
                (selecionadas.contains(tabela[idx]))
                    ? selecionadas.remove(tabela[idx])
                    : selecionadas.add(tabela[idx]);
              })
            },
          );
        },
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, ___) => const Divider(),
        itemCount: tabela.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).pop();
                final snackBar = SnackBar(
                  backgroundColor: Colors.green,
                  content: const Text('Lista pronta para ir ao Mercado! '),
                  action: SnackBarAction(
                    textColor: AppColors.whiteCuston,
                    label: 'Desfazer',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              icon: const Icon(Icons.add),
              label: const Text(
                'ADICIONAR NA LISTA',
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }
}
