import 'package:flutter/material.dart';

// La classe Filter représente un widget de boîte de dialogue pour sélectionner les filtres de statut de tâche.
class Filter extends StatefulWidget {
  final Map<String, bool>
      initialFilters; // Filtres initiaux pour les différents statuts de tâche
  final Function(Map<String, bool>)
      onFilterChanged; // Callback appelé lorsque les filtres sont modifiés

  const Filter({
    super.key,
    required this.initialFilters,
    required this.onFilterChanged,
  });

  @override
  createState() => _FilterState();
}

// L'état de la classe Filter
class _FilterState extends State<Filter> {
  late Map<String, bool> _filters; // Filtres locaux modifiables dans l'état

  @override
  void initState() {
    super.initState();
    _filters = Map.from(widget
        .initialFilters); // Initialisation des filtres locaux à partir des filtres initiaux du widget
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter par'), // Titre de la boîte de dialogue
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _filters.keys.map((status) {
            return CheckboxListTile(
              title: Text(status,
                  style: TextStyle(
                      color: _getStatusColor(
                          status))), // Texte du statut avec la couleur associée
              value: _filters[
                  status], // Valeur du checkbox correspondant au statut
              onChanged: (bool? value) {
                setState(() {
                  _filters[status] =
                      value!; // Mise à jour de la valeur du filtre lorsque le checkbox est modifié
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onFilterChanged(
                _filters); // Appel du callback avec les filtres mis à jour
            Navigator.of(context).pop(); // Fermeture de la boîte de dialogue
          },
          child: const Text('Appliquer'), // Bouton pour appliquer les filtres
        ),
      ],
    );
  }

  // Fonction pour obtenir la couleur associée à chaque statut de tâche
  Color _getStatusColor(String status) {
    switch (status) {
      case 'In progress':
        return Colors.blue;
      case 'Done':
        return Colors.green;
      case 'Bug':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
