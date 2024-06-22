import 'package:flutter/material.dart';
import 'package:gestion_de_taches/models/task_model.dart'; // Importation du modèle de tâche
import 'package:gestion_de_taches/widgets/filter.dart'; // Importation du widget de filtre
import 'package:gestion_de_taches/screens/add_task_screen.dart'; // Importation de l'écran d'ajout de tâche
import 'package:gestion_de_taches/screens/edit_task_screen.dart'; // Importation de l'écran de modification de tâche

// Déclaration de la classe principale de l'écran de liste de tâches
class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  createState() => _TaskListScreenState();
}

// Déclaration de l'état de l'écran de liste de tâches
class _TaskListScreenState extends State<TaskListScreen> {
  // Déclaration des filtres par statut pour filtrer les tâches affichées
  Map<String, bool> filters = {
    'Todo': true,
    'In progress': true,
    'Done': true,
    'Bug': true,
  };

  // Construction de l'interface utilisateur principale
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Définition de la couleur de l'app bar
        title: const Text(
          'Todo App',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => Filter(
                  initialFilters: filters,
                  onFilterChanged: (newFilters) {
                    setState(() {
                      filters = newFilters; // Mise à jour des filtres lorsque l'utilisateur change les paramètres
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: _buildTaskList(), // Construction de la liste des tâches
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigation vers l'écran d'ajout de tâche
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );
          if (result == true) {
            setState(() {}); // Rafraîchissement de l'état de l'application après ajout de tâche
          }
        },
        backgroundColor: Colors.black, // Définition de la couleur du bouton flottant
        child: const Icon(Icons.add, color: Colors.white), // Icône du bouton flottant
      ),
    );
  }

  // Méthode pour construire la liste des tâches
  Widget _buildTaskList() {
    final tasks = TaskModel().tasks; // Récupération des tâches à partir du modèle
    if (tasks.isEmpty) {
      return const Center(child: Text("Vous n'avez aucune tâche!")); // Message affiché lorsqu'il n'y a pas de tâches
    }
    return ListView.builder(
      itemCount: _filteredTasks().length, // Définition du nombre d'éléments dans la liste
      itemBuilder: (context, index) {
        final task = _filteredTasks()[index]; // Récupération de la tâche filtrée
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: _getStatusColor(task.status)), // Définition de la couleur de la bordure en fonction du statut
            borderRadius: BorderRadius.circular(5),
          ),
          child: ListTile(
            leading: Icon(Icons.circle, color: _getStatusColor(task.status)), // Icône indiquant le statut de la tâche
            title: Text(
              task.title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () async {
              // Navigation vers l'écran de modification de tâche
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskScreen(
                    task: task,
                    onUpdate: (updatedTask) {
                      setState(() {
                        TaskModel().updateTask(updatedTask); // Mise à jour de la tâche dans le modèle
                      });
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Méthode pour filtrer les tâches en fonction des filtres sélectionnés
  List<Task> _filteredTasks() {
    return TaskModel().tasks.where((task) {
      return filters[task.status]!; // Retourne les tâches dont le statut est sélectionné dans les filtres
    }).toList();
  }

  // Méthode pour obtenir la couleur associée à chaque statut
  Color _getStatusColor(String status) {
    switch (status) {
      case 'In progress':
        return Colors.blue; // Couleur pour le statut "In progress"
      case 'Done':
        return Colors.green; // Couleur pour le statut "Done"
      case 'Bug':
        return Colors.red; // Couleur pour le statut "Bug"
      default:
        return Colors.grey; // Couleur par défaut pour les autres statuts
    }
  }
}
