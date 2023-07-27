import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:idea/app_constants.dart';
import 'package:idea/constants/bloc_observer.dart';
import 'package:idea/cubits/change_mode_cubit/change_mode_cubit.dart';
import 'package:idea/models/note_model.dart';
import 'package:idea/views/notes_view.dart';

void main() async {
  await Hive.initFlutter();
  Bloc.observer = MyBlocObserver();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(kNotesBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Set the status bar color to dark background with white (light) text
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, // For transparent status bar
      statusBarIconBrightness: Brightness.light,
    ));

    // Determine the theme based on the current state of the ChangeModeCubit
    // final isDarkMode = state is DarkMode;
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => AddNoteCubit()),
        BlocProvider(
          create: (context) => ChangeModeCubit(),
        )
      ],
      child: BlocConsumer<ChangeModeCubit, ChangeModeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Idea',
            theme: ChangeModeCubit.get(context).isDarkMode
                ? AppThemes.darkTheme
                : AppThemes
                    .lightTheme, // Set the theme based on isNightMode flag

            home: const NotesView(),
          );
        },
      ),
    );
  }
}
