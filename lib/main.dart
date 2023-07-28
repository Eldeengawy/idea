import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:idea/app_constants.dart';
import 'package:idea/constants/bloc_observer.dart';
import 'package:idea/cubits/add_folder_cubit/add_folder_cubit.dart';
import 'package:idea/cubits/change_mode_cubit/change_mode_cubit.dart';
import 'package:idea/cubits/folders_cubit/folders_cubit_cubit.dart';
import 'package:idea/cubits/notes_cubit/notes_cubit_cubit.dart';
import 'package:idea/models/folder_model.dart';
import 'package:idea/models/note_model.dart';
import 'package:idea/views/notes_view.dart';

void main() async {
  await Hive.initFlutter();
  Bloc.observer = MyBlocObserver();
  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(FolderModelAdapter());
  await Hive.openBox<NoteModel>(kNotesBox);
  await Hive.openBox<FolderModel>(kFoldersBox);
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
        BlocProvider(create: (context) => AddFolderCubit()),
        // BlocProvider(create: (context) => FoldersCubit()),
        BlocProvider(
          create: (context) => ChangeModeCubit(),
        )
      ],
      child: BlocConsumer<ChangeModeCubit, ChangeModeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocProvider(
            create: (context) => FoldersCubit(),
            child: BlocProvider(
              create: (BuildContext context) => NotesCubit(),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Idea',
                theme: ChangeModeCubit.get(context).isDarkMode
                    ? AppThemes.darkTheme
                    : AppThemes
                        .lightTheme, // Set the theme based on isNightMode flag

                home: const NotesView(),
              ),
            ),
          );
        },
      ),
    );
  }
}
