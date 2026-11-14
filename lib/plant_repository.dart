import 'package:cloud_firestore/cloud_firestore.dart';

import 'plant_model.dart';

class PlantRepository {
  PlantRepository({FirebaseFirestore? firestore})
    : _plants = (firestore ?? FirebaseFirestore.instance).collection('plantas');

  final CollectionReference<Map<String, dynamic>> _plants;

  Future<List<Plant>> obtenerPlantas() async {
    // Firestore omite de orderBy los documentos sin el campo ordenado.
    // Ordenar aquí permite leer toda la colección mientras se valida el esquema.
    final snapshot = await _plants.get();
    final plantas = snapshot.docs
        .map((doc) => Plant.fromMap(doc.id, doc.data()))
        .toList();
    plantas.sort((a, b) => a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase()));
    return plantas;
  }

  Future<Plant?> obtenerPlantaPorId(String id) async {
    final doc = await _plants.doc(id).get();
    final data = doc.data();
    return doc.exists && data != null ? Plant.fromMap(doc.id, data) : null;
  }
}
