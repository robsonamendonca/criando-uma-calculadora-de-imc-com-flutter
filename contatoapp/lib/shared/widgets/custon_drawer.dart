import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class CustonDrawer extends StatelessWidget {
  final TabController tabController;
  final String nomeUsuario;
  final String emailUsuario;
  const CustonDrawer(
      {Key? key,
      required this.tabController,
      required this.nomeUsuario,
      required this.emailUsuario})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(emailUsuario),
            accountName: Text(nomeUsuario),
            currentAccountPicture: const CircleAvatar(
              child: Text("UR"),
            ),
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.house,
                      color: Colors.blue,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("APP_ICO_HOME".tr()),
                  ],
                )),
            onTap: () async {
              //await launchUrl(Uri.parse("https://dio.me"));
              tabController.animateTo(0);
              Navigator.pop(context);
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.cakeCandles,
                      color: Colors.blue,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("APP_ICO_ANIV".tr()),
                  ],
                )),
            onTap: () async {
              tabController.animateTo(1);
              Navigator.pop(context);
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.listCheck,
                      color: Colors.blue,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("APP_ICO_OPCS".tr()),
                  ],
                )),
            onTap: () {
              // Share.share(
              //   'Olhem esse site, que legal! https://dio.me',
              // );
              tabController.animateTo(2);
              Navigator.pop(context);
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.github,
                      color: Colors.black,
                      size: 24,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("DEV - Github"),
                  ],
                )),
            onTap: () async {
              await launchUrl(Uri.parse("https://github.com/robsonamendonca"));
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.linkedinIn,
                      color: Colors.blue,
                      size: 24,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("DEV - Linkedin"),
                  ],
                )),
            onTap: () async {
              await launchUrl(
                  Uri.parse("https://www.linkedin.com/in/robsonamendonca/"));
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child:  Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.dev,
                      color: Colors.black,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("APP_ICO_DEV".tr()),
                  ],
                )),
            onTap: () async {
              await launchUrl(
                  Uri.parse("https://about.me/robsonamendonca"));
            },
          ),
        ].toList(),
      ),
    );
  }
}
