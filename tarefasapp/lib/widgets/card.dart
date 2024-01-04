// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tarefasapp/pages/home_page.dart';
import 'package:tarefasapp/pages/list_page.dart';
import 'package:tarefasapp/shared/app_colors.dart';
import 'package:badges/badges.dart' as badges;
import 'package:tarefasapp/shared/app_images.dart';
import 'package:tarefasapp/widgets/modal_message.dart';

class CardWidget extends StatelessWidget {
  final Icon iconD;
  final String description;
  late bool useBadge = false;
  late int qtdItem = 0;
  late String usuario;
  CardWidget(
      {super.key,
      required this.iconD,
      required this.description,
      required this.useBadge,
      required this.qtdItem,
      required this.usuario});

  @override
  Widget build(BuildContext context) {
    bool checkUseBadge = useBadge;
    checkUseBadge = qtdItem > 0 ? true : false;
    return InkWell(
      onTap: () {
        if (qtdItem <= 0) {
          modalMessage(
              context,
              'Espere',
              'Agora vamos selecionar uma categoria e selecionar os itens para a lista e ir ao mercado!',
              AppImages.emojiSorrindoEspere,
              'Continuar'
              );
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ListPage()));
        }
      },
      child: Card(
        elevation: 1.3,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: 64,
          height: 64,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !checkUseBadge
                  ? iconD
                  : _cardBadge(true, const Color.fromARGB(255, 11, 103, 179),
                      qtdItem.toString(), iconD),
              const SizedBox(
                height: 16,
              ),
              Text(
                description,
                style: TextStyle(fontSize: 16, color: AppColors.azulEscuro),
              )
            ],
          ),
        ),
      ),
    );
  }

 fechaTela(context) {    
  debugPrint('clicou agora tem que fechar!');
    Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  HomePage(username: usuario,)));
  }

  Widget _cardBadge(bool showBadge, Color color, String qtdItem, widgetIcon) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 0, end: -7),
      badgeAnimation: const badges.BadgeAnimation.scale(
        disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
        curve: Curves.easeInCubic,
      ),
      showBadge: showBadge,
      badgeStyle: badges.BadgeStyle(
        badgeColor: color,
      ),
      badgeContent: Text(
        qtdItem,
        style: const TextStyle(color: Colors.white),
      ),
      child: widgetIcon,
    );
  }
}
