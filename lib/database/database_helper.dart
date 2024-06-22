//import 'package:path/path.dart'; // Importation de la bibliothèque path pour gérer les chemins de fichiers de manière compatible avec toutes les plateformes
import 'package:sqflite/sqflite.dart'; // Importation de la bibliothèque sqflite pour la gestion de la base de données SQLite

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper
      ._internal(); // Création d'une instance singleton de DatabaseHelper
  static Database?
      _database; // Variable privée pour stocker l'instance de la base de données

  factory DatabaseHelper() {
    return _instance; // Retourne l'instance singleton
  }

  DatabaseHelper._internal(); // Constructeur privé pour empêcher l'instanciation multiple

  Future<Database> get database async {
    if (_database != null) {
      return _database!; // Si la base de données est déjà initialisée, retourne-la
    }
    _database = await _initDatabase(); // Sinon, initialise la base de données
    return _database!; // Retourne l'instance de la base de données
  }

  Future<Database> _initDatabase() async {
    String path = 'C:/laragon/www/gestion_de_taches/tasks.db'; // Chemin complet de la base de données
    return await openDatabase(
      path,
      version: 1,
      onCreate:
          _onCreate, // Spécifie la méthode à appeler lors de la création de la base de données
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        status TEXT
      )
    '''); // Création de la table tasks avec les champs id, title, description et status
  }

  Future<int> insertTask(Map<String, String> task) async {
    Database db = await database; // Obtient l'instance de la base de données
    return await db.insert(
        'tasks', task); // Insère une nouvelle tâche dans la table tasks
  }

  Future<int> updateTask(Map<String, String> task) async {
    Database db = await database; // Obtient l'instance de la base de données
    int id = int.parse(task['id']!); // Convertit l'id de la tâche en entier
    return await db.update(
      'tasks', // Met à jour la table tasks
      task, // Nouvelles valeurs de la tâche
      where: 'id = ?', // Condition pour identifier la tâche à mettre à jour
      whereArgs: [id], // Argument pour la condition where
    );
  }

  Future<int> deleteTask(int id) async {
    Database db = await database; // Obtient l'instance de la base de données
    return await db.delete(
      'tasks', // Supprime de la table tasks
      where: 'id = ?', // Condition pour identifier la tâche à supprimer
      whereArgs: [id], // Argument pour la condition where
    );
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    Database db = await database; // Obtient l'instance de la base de données
    return await db
        .query('tasks'); // Récupère toutes les tâches de la table tasks
  }
}
