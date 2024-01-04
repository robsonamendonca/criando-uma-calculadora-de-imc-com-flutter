import 'package:flutter/material.dart';
import 'package:tarefasapp/shared/app_colors.dart';

class HeaderWidget extends StatelessWidget {
  final String username;
  const HeaderWidget({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Olá',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColors.azulEscuro,
                fontWeight: FontWeight.w400,
                fontSize: 25,
              ),
        ),
        Text(
          username,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColors.azulEscuro,
                fontWeight: FontWeight.w700,
                fontSize: 28,
              ),
        ),
      ],
    );
  }
}
