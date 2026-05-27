import 'dart:io';
import 'dart:convert';

//Implementación de clases y objetos para modelar los datos
class Registro {
  final String nombre;
  final int edad;
  final double salario;

  Registro({required this.nombre, required this.edad, required this.salario});

  //Factory para crear una instancia desde un mapa JSON
  factory Registro.fromJson(Map<String, dynamic> json) {
    return Registro(
      nombre: json['nombre'] ?? 'Sin nombre',
      edad: json['edad'] ?? 0,
      salario: (json['salario'] as num?)?.toDouble() ?? 0.0,
    );
  }

  //Para exportar a JSON 
  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'edad': edad,
    'salario': salario,
  };

  @override
  String toString() => 'Nombre: $nombre | Edad: $edad | Salario: \$${salario.toStringAsFixed(2)}';
}

void main() async {
  final String filePath = 'datos.json';
  List<Registro> registros = [];

  //Carga de archivos usando dart:io y dart:convert 
  try {
    final file = File(filePath);
    if (await file.exists()) {
      final String content = await file.readAsString();
      final List<dynamic> jsonData = json.decode(content);
      registros = jsonData.map((item) => Registro.fromJson(item)).toList();
      print('--- Archivo cargado exitosamente (${registros.length} registros) ---');
    } else {
      print('Error: El archivo $filePath no existe.');
      return;
    }
  } catch (e) {
    print('Error al leer el archivo: $e');
    return;
  }

  // Interfaz en consola y menú interactivo 
  bool salir = false;
  while (!salir) {
    print('\n--- MENÚ DE ANÁLISIS DE DATOS ---');
    print('1. Mostrar todos los registros');
    print('2. Buscar por nombre');
    print('3. Calcular estadísticas');
    print('4. Exportar resumen a JSON');
    print('5. Salir');
    stdout.write('Seleccione una opción: ');
    
    String? opcion = stdin.readLineSync();

    switch (opcion) {
      case '1':
        registros.forEach(print);
        break;
      case '2':
        buscarRegistro(registros); 
        break;
      case '3':
        generarEstadisticas(registros); 
        break;
      case '4':
        await exportarResumen(registros); 
        break;
      case '5':
        salir = true;
        break;
      default:
        print('Opción no válida.');
    }
  }
}

//Procesamiento y búsqueda de datos
void buscarRegistro(List<Registro> lista) {
  stdout.write('Ingrese el nombre a buscar: ');
  String? busqueda = stdin.readLineSync()?.toLowerCase();

  //Aplicación de Null Safety para evitar errores
  if (busqueda != null && busqueda.isNotEmpty) {
    var resultados = lista.where((r) => r.nombre.toLowerCase().contains(busqueda)).toList();
    if (resultados.isEmpty) {
      print('No se encontraron coincidencias.');
    } else {
      resultados.forEach(print);
    }
  }
}

//Generación de reportes y estadísticas básicas 
void generarEstadisticas(List<Registro> lista) {
  if (lista.isEmpty) return;

  double sumaSalarios = lista.fold(0, (prev, element) => prev + element.salario);
  double promedio = sumaSalarios / lista.length;
  
  int edadMin = lista.map((e) => e.edad).reduce((a, b) => a < b ? a : b);
  int edadMax = lista.map((e) => e.edad).reduce((a, b) => a > b ? a : b);

  print('\n--- ESTADÍSTICAS ---');
  print('Total de registros: ${lista.length}');
  print('Salario promedio: \$${promedio.toStringAsFixed(2)}');
  print('Edad mínima: $edadMin');
  print('Edad máxima: $edadMax');
}

// Exportar un resumen de datos a un nuevo archivo JSON con estadísticas incluidas
Future<void> exportarResumen(List<Registro> lista) async {
  if (lista.isEmpty) {
    print('No hay datos para exportar.');
    return;
  }
  //Calcular las estadísticas básicas 
  double sumaSalarios = lista.fold(0, (prev, element) => prev + element.salario);
  double promedio = sumaSalarios / lista.length;
  
  int edadMin = lista.map((e) => e.edad).reduce((a, b) => a < b ? a : b);
  int edadMax = lista.map((e) => e.edad).reduce((a, b) => a > b ? a : b);

  // Agregar los cálculos al mapa del resumen
  final resumen = {
    'fecha_generacion': DateTime.now().toIso8601String(),
    'estadisticas_generales': {
      'total_registros': lista.length,
      'salario_promedio': double.parse(promedio.toStringAsFixed(2)),
      'edad_minima': edadMin,
      'edad_maxima': edadMax,
    },
    'datos_detallados': lista.map((e) => e.toJson()).toList(),
  };

  try {
    final file = File('resumen_analisis.json');    
    const encoder = JsonEncoder.withIndent('  ');
    await file.writeAsString(encoder.convert(resumen));
    
    print('--- Resumen estadístico exportado exitosamente a "resumen_analisis.json" ---');
  } catch (e) {
    print('Error al exportar el archivo: $e');
  }
}

