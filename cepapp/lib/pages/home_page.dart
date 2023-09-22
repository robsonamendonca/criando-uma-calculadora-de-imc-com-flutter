// ignore_for_file: deprecated_member_use
import 'package:cepapp/model/ceps_back4app_model.dart';
import 'package:cepapp/pages/cep_busca_page.dart';
import 'package:cepapp/pages/cep_page.dart';
import 'package:cepapp/repositories/cep_back4app_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CepsBack4AppRepository cepRepository = CepsBack4AppRepository();
  var cepsBack4App = CepsBack4AppModel([]);
  late bool carregando = true;
  var qtdCepsCadastrados = "0";
  var qtdCepsAlterados = "0";
  var qtdCepsEmSP = "0";
  var qtdCepsComPaulista = "0";

  @override
  void initState() {
    super.initState();
    obterCeps();
  }

  void obterCeps() async {
    setState(() {
      carregando = true;
    });
    cepsBack4App = (await cepRepository.obterCeps());
    setState(() {
      qtdCepsCadastrados = cepsBack4App.ceps.length.toString();
      qtdCepsAlterados = getAlterados();
      qtdCepsEmSP = getEmSP();
      qtdCepsComPaulista = getPaulista();
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF433D82),
        elevation: 0,
        actions: <Widget>[
          InkWell(
            child: const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.menu,
                color: Color(0xFF433D82),
              ),
            ),
            onTap: () {
              showTelaCep(context);
            },
          ),
        ],
      ),
      body: (carregando) ? Container() : _buildBody(context),
    );
  }

  Future<dynamic> showTelaCep(BuildContext context) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CepPage()));
  }

  Widget _buildBody(BuildContext context) {
    obterCeps();
    return Stack(
      children: <Widget>[
        _buildBodyContent(context),
        Align(
          alignment: FractionalOffset.bottomRight,
          child: _buildAddButton(context),
        ),
      ],
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _buildHelloWidget(context: context, name: 'Usuário'),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _buildDateWidget(context: context),
          ),
          const SizedBox(height: 20.0),
          const Divider(),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _buildTaskTypesWidget(context: context),
          ),
          const SizedBox(height: 10.0),
          const Divider(),
          const SizedBox(height: 20.0),
          _buildGridView(context)
        ],
      ),
    );
  }

  Widget _buildHelloWidget(
      {required BuildContext context, required String name}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Olá',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: const Color(0xFF433D82),
                fontWeight: FontWeight.w400,
                fontSize: 28,
              ),
        ),
        Text(
          name,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: const Color(0xFF433D82),
                fontWeight: FontWeight.w700,
                fontSize: 35,
              ),
        ),
      ],
    );
  }

  Widget _buildDateWidget({required BuildContext context}) {
    return RichText(
      text: const TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xFF878695),
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Bem-vindo(a), ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ' ao aplicativo de CEPs',
            style: TextStyle(),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskTypesWidget({required BuildContext context}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildTaskStatusWidget(
              context: context,
              count: qtdCepsCadastrados,
              title: 'Cadastrados'),
          _buildTaskStatusWidget(
              context: context, count: qtdCepsAlterados, title: 'Alterados'),
        ]);
  }

  Widget _buildTaskStatusWidget(
      {required BuildContext context, String? count, String? title}) {
    return Row(
      children: <Widget>[
        Text(
          count!,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: const Color(0xFF433D82),
              ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Text(
          'CEPs \n$title',
          style: const TextStyle(
            color: Color(0xFF878695),
          ),
        )
      ],
    );
  }

  Widget _buildGridView(BuildContext context) {
    // Dimensions in logical pixels (dp)
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    //double height = size.height;
    return Flexible(
      child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
          crossAxisSpacing: width * 0.025,
          children: <Widget>[
            _buildGridTile(
                context: context,
                icon: Icons.library_books,
                title: 'Em SP',
                subTitle: '$qtdCepsEmSP CEPs'),
            _buildGridTile(
                context: context,
                icon: Icons.school,
                title: 'Com Paulista',
                subTitle: '$qtdCepsComPaulista CEPs'),
          ].map((Widget child) {
            return GridTile(child: child);
          }).toList()),
    );
  }

  Widget _buildGridTile(
      {required BuildContext context,
      required IconData icon,
      String? title,
      String? subTitle}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.lightGreen,
      ),
      title: Text(
        title!.replaceAll(" ", "\n"),
      ),
      subtitle: Text(
        subTitle!,
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
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CepBuscaPage()),
        ),
        child: const Icon(Icons.search, color: Colors.white),
      ),
    );
  }

  String getAlterados() {
    var result = cepsBack4App.ceps.map((e) {
      if (e.createdAt != null) {
        DateTime startDate = DateTime.parse('${e.createdAt}');
        DateTime? endDate =
            e.updatedAt != null ? DateTime.parse('${e.updatedAt}') : null;
        //var now = DateTime.now();

        if ((startDate != endDate)) {
          return e;
        }
      }
    }).toList();
    result.removeWhere((element) => element == null);
    return result.length.toString();
  }

  String getEmSP() {
    var result = cepsBack4App.ceps.map((e) {
      if (e.uf != null) {
        if (e.uf?.toUpperCase() == "SP") {
          return e;
        }
      }
    }).toList();
    result.removeWhere((element) => element == null);
    return result.length.toString();
  }

  String getPaulista() {
    var result = cepsBack4App.ceps.map((e) {
      if (e.logradouro != null) {
        if (e.logradouro!.toUpperCase().contains("PAULISTA")) {
          return e;
        }
      }
    }).toList();
    result.removeWhere((element) => element == null);
    return result.length.toString();
  }
}
