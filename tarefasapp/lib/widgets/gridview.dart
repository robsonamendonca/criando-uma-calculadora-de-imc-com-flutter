// ignore_for_file: must_be_immutable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:tarefasapp/models/category_purchase_,model.dart';
import 'package:tarefasapp/pages/select_page.dart';
import 'package:tarefasapp/shared/app_colors.dart';

class GridViewWidget extends StatelessWidget {
  final List<CategoryPurchase> categoryPurchase;
  const GridViewWidget(this.categoryPurchase, {super.key,});

  @override
  Widget build(BuildContext context) {
    debugPrint('GRID: ${categoryPurchase.length}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            'Categorias recomendadas',
            style: TextStyle(
                color: AppColors.azulEscuro,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 240,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                width: 210,
                decoration: BoxDecoration(
                    color: AppColors.azulClaro.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // new Image(image: new AssetImage('/assets/heaven.gif')),
                      children: [
                        Image.network(categoryPurchase[index].urlPhoto!),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          categoryPurchase[index].name!,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.azulEscuro,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectPage(
                                    title: categoryPurchase[index].name!)))
                      },
                      child: Container(
                        height: 45,
                        width: 130,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              categoryPurchase[index].objectId! != "0"
                                  ? Colors.green
                                  : Colors.transparent,
                              categoryPurchase[index].objectId! != "0"
                                  ? Colors.lightGreen
                                  : Colors.transparent
                            ]),
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: Text(
                            'Selecionar',
                            style: TextStyle(
                                color: categoryPurchase[index].objectId! != "0"
                                    ? Colors.white
                                    : const Color(0xffC58BF2),
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 25,
            ),
            itemCount: categoryPurchase.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
          ),
        )
      ],
    );
  }
}
