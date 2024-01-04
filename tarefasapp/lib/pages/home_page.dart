// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarefasapp/pages/options_page.dart';
import 'package:tarefasapp/services/app_storage_service.dart';
import 'package:tarefasapp/services/category_purchase_service.dart';
import 'package:tarefasapp/shared/app_colors.dart';
import 'package:tarefasapp/shared/app_settings.dart';
import 'package:tarefasapp/widgets/card.dart';
import 'package:tarefasapp/widgets/gridview.dart';
import 'package:tarefasapp/widgets/header.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    AppStorageService storage = AppStorageService();
    final CategoryPurchaseService categorys = Provider.of(context);

    return Scaffold(
      backgroundColor: AppColors.whiteCuston,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Stack(
              children: [
                Positioned(
                  top: (AppSettings.screenHeight / 5) - 137,
                  right: (AppSettings.screenWidth / 2) - 177,
                  child: CardWidget(
                      useBadge: true,
                      qtdItem: 0,
                      description: "Lista",
                      iconD: Icon(
                        Icons.list_alt_outlined,
                        color: AppColors.azulEscuro,
                      ),
                      usuario: username),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        HeaderWidget(username: username),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0), // 32
                            child: Text(
                              'Em qual seção \nvocê quer começar?',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: AppColors.azulEscuro,
                                    fontSize: 18,
                                  ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GridViewWidget(categorys.all),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Minhas listas',
                            style: TextStyle(
                                color: AppColors.azulEscuro,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ListView.separated(
                          itemCount: categorys.count,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 25,
                          ),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          itemBuilder: (context, index) {
                            var category = categorys.byIndex(index);
                            return Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0xff1D1617)
                                            .withOpacity(0.07),
                                        offset: const Offset(0, 10),
                                        blurRadius: 40,
                                        spreadRadius: 0)
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // new Image(image: new AssetImage('/assets/heaven.gif')),
                                    children: [
                                      Image(
                                        image: AssetImage(
                                          category.urlPhoto!,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        category.name!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.azulEscuro,
                                            fontSize: 16),
                                      ),
                                      const Text(
                                        "Data e hora",
                                        style: TextStyle(
                                            color: Color(0xff7B6F72),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.chevron_right,
                                      color: Color(0xFF433D82),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: AppColors.cinzaClaro,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.red,
            textTheme: Theme.of(context).textTheme.copyWith(
                bodySmall: const TextStyle(
                    color: Colors
                        .yellow))), // sets the inactive color of the `BottomNavigationBar`
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          onTap: (value) {
            if (value == 0) {
              navegatoToHome(context, storage);
            } else {
              navegatoToOptions(context);
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: ("Home"),
              tooltip: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: ("Opções"),
              tooltip: "Opções",
            )
          ],
        ),
      ),
    );
  }

  void navegatoToHome(BuildContext context, storage) {
    var username = storage.getConfiguracoesNomeUsuario();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomePage(username: username)));
  }

  void navegatoToOptions(
    BuildContext context,
  ) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const OptionsPage()));
  }
}
