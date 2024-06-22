import 'package:flutter/material.dart';
import 'package:gestion_de_taches/models/task_model.dart'; // Importation du modèle de tâche

// Déclaration de la classe EditTaskScreen qui est un StatefulWidget
class EditTaskScreen extends StatefulWidget {
  final Task task; // La tâche à modifier, de type Task
  final Function(Task) onUpdate; // Callback pour mettre à jour la tâche, de type Function(Task)

  // Constructeur avec des paramètres requis
  const EditTaskScreen({super.key, required this.task, required this.onUpdate});

  @override
  createState() => _EditTaskScreenState(); // Création de l'état associé
}

// Déclaration de l'état de l'écran EditTaskScreen
class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _titleController; // Contrôleur pour le champ de titre
  late TextEditingController _descriptionController; // Contrôleur pour le champ de description
  late String _status; // Variable pour stocker le statut de la tâche

  @override
  void initState() {
    super.initState();
    // Initialisation des contrôleurs avec les valeurs existantes de la tâche
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    _status = widget.task.status;
  }

  @override
  void dispose() {
    // Libération des ressources des contrôleurs lorsqu'ils ne sont plus nécessaires
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Définition de la couleur de l'app bar
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Todo App', style: TextStyle(color: Colors.white)), // Titre de l'app bar
          ),
        ),
      ),
      // Corps de l'écran contenant les champs de texte et le bouton pour modifier la tâche
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ligne contenant le titre "Modifier" et un menu déroulant pour le statut de la tâche
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Modifier',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                // Conteneur pour styliser le menu déroulant
                Container(
                  width: 150, // Définit une largeur fixe pour le conteneur du menu déroulant
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  // Masque la ligne de soulignement par défaut du menu déroulant
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _status, // Valeur sélectionnée
                      icon: const Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      // Met à jour le statut lorsqu'un nouvel élément est sélectionné
                      onChanged: (String? newValue) {
                        setState(() {
                          _status = newValue!;
                        });
                      },
                      // Définition des éléments du menu déroulant
                      items: <String>['Todo', 'In progress', 'Done', 'Bug']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: _getStatusColor(value),
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  value,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      // Définition de l'apparence de l'élément sélectionné
                      selectedItemBuilder: (BuildContext context) {
                        return <String>['Todo', 'In progress', 'Done', 'Bug']
                            .map<Widget>((String value) {
                          return Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: _getStatusColor(_status),
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Status',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Champ de texte pour le titre de la tâche
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Nouvelle tache',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Champ de texte pour la description de la tâche
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Bouton pour modifier la tâche
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Création d'une nouvelle instance de Task avec les valeurs mises à jour
                  final updatedTask = Task(
                    id: widget.task.id,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    status: _status,
                  );
                  widget.onUpdate(updatedTask); // Appel du callback onUpdate avec la tâche mise à jour
                  Navigator.pop(context, true); // Retour à l'écran précédent
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Fond noir
                  minimumSize: const Size(150, 50),
                ),
                child: const Text('Modifier',
                    style: TextStyle(fontSize: 18, color: Colors.white)), // Texte blanc
              ),
            ),
          ],
        ),
      ),
      // Bouton flottant pour fermer l'écran
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); // Retour à l'écran précédent
        },
        backgroundColor: Colors.black, // Fond noir
        child: const Icon(Icons.close, color: Colors.white), // Icône blanche
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
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
