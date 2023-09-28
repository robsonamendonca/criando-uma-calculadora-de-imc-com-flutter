import 'package:contatoapp/pages/aniver_list_page.dart';
import 'package:contatoapp/pages/configuracoes/configuracoes_shared_preferences_page.dart';
import 'package:contatoapp/pages/contact_list_page.dart';
import 'package:contatoapp/repositories/contato_back4app_repository.dart';
import 'package:contatoapp/services/app_storage_service.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:contatoapp/shared/widgets/custon_drawer.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;
  AppStorageService storage = AppStorageService();
  String nomeUsuario = "";
  String emailUsuario = "";
  String idioma = "pt_BR";
  bool exibirContador = false;
  int qtdeContatosCadastrados = 0;
  int qtdeContatosAniver = 0;
  String strQtdeContatosCadastrados = '';
  String strQtdeContatosAniver = '';

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    getSharedPreferencesData();
  }

  void getSharedPreferencesData() async {
    nomeUsuario = await storage.getConfiguracoesNomeUsuario();
    emailUsuario = await storage.getConfiguracoesEmailUsuario();
    exibirContador = await storage.getConfiguracoesExibirContador();
    idioma = await storage.getConfiguracoesIdioma();

    if (exibirContador) {
      ContatosBack4AppRepository contatoRepository =
          ContatosBack4AppRepository();
      qtdeContatosAniver = await contatoRepository.obterQtdeAniverContatos();
      qtdeContatosCadastrados = await contatoRepository.obterQtdeContatos();
      if (qtdeContatosAniver >= 100) {
        strQtdeContatosAniver = "+99";
      } else {
        strQtdeContatosAniver = qtdeContatosAniver.toString();
      }
      if (qtdeContatosCadastrados >= 100) {
        strQtdeContatosCadastrados = "+99";
      } else {
        strQtdeContatosCadastrados = qtdeContatosCadastrados.toString();
      }
    }
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustonDrawer(
        tabController: tabController,
        nomeUsuario: nomeUsuario,
        emailUsuario: emailUsuario,
      ),
      appBar: AppBar(
        title: Text(
          "APP_TITLE".tr(),
          style: GoogleFonts.roboto(),
        ),
        actions: const <Widget>[],
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ContactListPage(tabController: tabController),
          AniverListPage(
            tabController: tabController,
          ),
          ConfiguracoesSharedPreferencesPage(
            tabController: tabController,
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar.badge(
        {
          0: exibirContador ? strQtdeContatosCadastrados.toString() : '',
          1: exibirContador ? strQtdeContatosAniver.toString() : '',
          2: ''
        },
        items: [
          TabItem(icon: Icons.home, title: "APP_ICO_HOME".tr()),
          TabItem(icon: Icons.cake_rounded, title: "APP_ICO_ANIV".tr()),
          TabItem(icon: Icons.toc_outlined, title: "APP_ICO_OPCS".tr()),
        ],
        onTap: (int i) => tabController.index = i,
        controller: tabController,
        badgeColor: Colors.black,
        badgeTextColor: Colors.white,
      ),
    );
  }
}
