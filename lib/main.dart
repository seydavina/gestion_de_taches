import 'package:flutter/material.dart';
import 'screens/task_list_screen.dart'; // Importation de l'écran principal de la liste des tâches

void main() {
  runApp(const MyApp()); // Fonction principale qui lance l'application Flutter
}

// Classe principale de l'application qui étend StatelessWidget car l'application n'a pas d'état mutable à ce niveau
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Todo App', // Titre de l'application
      theme: ThemeData(
        primarySwatch: Colors
            .blue, // Thème de l'application avec une couleur primaire bleue
      ),
      home:
          const TaskListScreen(), // Écran d'accueil de l'application, défini comme TaskListScreen
    );
  }
}
