import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea/cubits/change_mode_cubit/change_mode_cubit.dart';
import 'package:idea/views/widgets/custom_mode_switch_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key, required this.title, required this.isWithIcon});
  final String title;
  final bool isWithIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          // 'IDEA',
          style:
              Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 28.0),
        ),
        if (isWithIcon)
          BlocProvider(
            create: (context) => ChangeModeCubit(),
            child: CustomModeSwitchButton(
              isNightMode: ChangeModeCubit.get(context).isDarkMode,
              onTap: () {
                BlocProvider.of<ChangeModeCubit>(context).toggleMode();
              },
            ),
          ),
      ],
    );
  }
}
