import 'dart:io';
import 'dart:math';

class Tema {
  String nombre;
  int numEstudiantes;
  List<String> estudiantesAsignados = [];

  Tema(this.nombre, this.numEstudiantes);
}

List<Tema> listaTemas = [];
List<String> listaEstudiantes = [];

void main() {
  int opcion;
  do {
    mostrarMenu();
    opcion = leerEntero("Seleccione una opción: ");

    switch (opcion) {
      case 1:
        gestionarTemas();
        break;
      case 2:
        gestionarEstudiantes();
        break;
      case 3:
        asignarEstudiantes();
        break;
      case 4:
        cargarDatosPrueba();
        break;
      case 5:
        print('Cerrando el programa...');
        break;
      default:
        print('Opción no válida');
    }
  } while (opcion != 5);
}

void mostrarMenu() {
  print('\nMENU PRINCIPAL');
  print('1. Gestión de temas');
  print('2. Gestión de estudiantes');
  print('3. Asignar estudiantes al azar');
  print('4. Cargar datos de prueba');
  print('5. Salir');
}

void gestionarTemas() {
  int opcion;
  do {
    print("\n--- Gestión de Temas ---");
    print("1. Crear nuevo tema");
    print("2. Modificar tema");
    print("3. Ver temas");
    print("4. Borrar tema");
    print("5. Regresar al menú principal");

    opcion = leerEntero("Elija una opción: ");

    switch (opcion) {
      case 1:
        crearNuevoTema();
        break;
      case 2:
        modificarTema();
        break;
      case 3:
        verTemas();
        break;
      case 4:
        borrarTema();
        break;
      case 5:
        print("Regresando al menú principal...");
        break;
      default:
        print("Opción incorrecta");
    }
  } while (opcion != 5);
}

void crearNuevoTema() {
  String nombre = leerCadena("Introduzca el nombre del tema: ");
  int cantidad = leerEntero("Introduzca la cantidad de estudiantes para este tema: ");
  listaTemas.add(Tema(nombre, cantidad));
  print("Tema creado exitosamente");
}

void modificarTema() {
  verTemas();
  if (listaTemas.isEmpty) return;

  int indice = leerEntero("Seleccione el número del tema a modificar: ") - 1;
  if (indice >= 0 && indice < listaTemas.length) {
    String nuevoNombre = leerCadena("Introduzca el nuevo nombre del tema: ");
    int nuevaCantidad = leerEntero("Introduzca la nueva cantidad de estudiantes: ");
    listaTemas[indice].nombre = nuevoNombre;
    listaTemas[indice].numEstudiantes = nuevaCantidad;
    print("Tema modificado correctamente");
  } else {
    print("Índice inválido");
  }
}

void verTemas() {
  if (listaTemas.isEmpty) {
    print('No hay temas disponibles.');
  } else {
    print('Lista de temas:');
    for (int i = 0; i < listaTemas.length; i++) {
      print('${i + 1}. ${listaTemas[i].nombre} (${listaTemas[i].numEstudiantes} estudiantes)');
    }
  }
}

void borrarTema() {
  verTemas();
  if (listaTemas.isEmpty) return;

  int indice = leerEntero("Seleccione el número del tema a borrar: ") - 1;
  if (indice >= 0 && indice < listaTemas.length) {
    listaTemas.removeAt(indice);
    print("Tema eliminado correctamente");
  } else {
    print("Índice inválido");
  }
}

void gestionarEstudiantes() {
  int opcion;
  do {
    print("\n--- Gestión de Estudiantes ---");
    print("1. Añadir estudiante");
    print("2. Modificar estudiante");
    print("3. Ver estudiantes");
    print("4. Borrar estudiante");
    print("5. Regresar al menú principal");

    opcion = leerEntero("Elija una opción: ");

    switch (opcion) {
      case 1:
        anadirEstudiante();
        break;
      case 2:
        modificarEstudiante();
        break;
      case 3:
        verEstudiantes();
        break;
      case 4:
        borrarEstudiante();
        break;
      case 5:
        print("Regresando al menú principal...");
        break;
      default:
        print("Opción incorrecta");
    }
  } while (opcion != 5);
}

void anadirEstudiante() {
  String nombre = leerCadena("Introduzca el nombre completo del estudiante: ");
  listaEstudiantes.add(nombre);
  print("Estudiante añadido correctamente");
}

void modificarEstudiante() {
  verEstudiantes();
  if (listaEstudiantes.isEmpty) return;

  int indice = leerEntero("Seleccione el número del estudiante a modificar: ") - 1;
  if (indice >= 0 && indice < listaEstudiantes.length) {
    String nuevoNombre = leerCadena("Introduzca el nuevo nombre completo del estudiante: ");
    listaEstudiantes[indice] = nuevoNombre;
    print("Estudiante modificado correctamente");
  } else {
    print("Índice inválido");
  }
}

void verEstudiantes() {
  if (listaEstudiantes.isEmpty) {
    print('No hay estudiantes disponibles.');
  } else {
    print('Lista de estudiantes:');
    for (int i = 0; i < listaEstudiantes.length; i++) {
      print('${i + 1}. ${listaEstudiantes[i]}');
    }
  }
}

void borrarEstudiante() {
  verEstudiantes();
  if (listaEstudiantes.isEmpty) return;

  int indice = leerEntero("Seleccione el número del estudiante a borrar: ") - 1;
  if (indice >= 0 && indice < listaEstudiantes.length) {
    listaEstudiantes.removeAt(indice);
    print("Estudiante eliminado correctamente");
  } else {
    print("Índice inválido");
  }
}

void asignarEstudiantes() {
  if (listaTemas.isEmpty || listaEstudiantes.isEmpty) {
    print("No hay suficientes temas o estudiantes para realizar la asignación.");
    return;
  }

  for (var tema in listaTemas) {
    tema.estudiantesAsignados.clear();
  }

  List<String> estudiantesSinAsignar = List.from(listaEstudiantes);
  Random random = Random();

  for (var tema in listaTemas) {
    int cantidadAsignar = min(tema.numEstudiantes, estudiantesSinAsignar.length);
    for (int i = 0; i < cantidadAsignar; i++) {
      if (estudiantesSinAsignar.isNotEmpty) {
        int indiceAleatorio = random.nextInt(estudiantesSinAsignar.length);
        tema.estudiantesAsignados.add(estudiantesSinAsignar[indiceAleatorio]);
        estudiantesSinAsignar.removeAt(indiceAleatorio);
      }
    }
  }

  print("\nAsignación de estudiantes a temas:");
  for (var tema in listaTemas) {
    print("${tema.nombre}:");
    for (var estudiante in tema.estudiantesAsignados) {
      print("  - $estudiante");
    }
  }

  if (estudiantesSinAsignar.isNotEmpty) {
    print("\nEstudiantes sin asignar:");
    for (var estudiante in estudiantesSinAsignar) {
      print("  - $estudiante");
    }
  }
}

void cargarDatosPrueba() {
  listaTemas = [
    Tema("¿Qué es POO?", 3),
    Tema("Diferencias entre POO y PE", 3),
    Tema("Objetos y clases, ¿cuál es la diferencia?", 3),
    Tema("¿Qué es la abstracción?", 3),
    Tema("¿Qué es la encapsulación?", 3),
    Tema("¿Qué es la herencia?", 4),
    Tema("¿Qué es el polimorfismo? Ejemplos", 4),
    Tema("Principales diagramas de UML", 4),
  ];

  listaEstudiantes = [
    "ANDRES FELIPE SANCHEZ HURTADO",
    "ANGIE DAHIANA RIOS QUINTERO",
    "CRISTIAN ALVAREZ ARANZAZU",
    "DANIEL ESTIVEN ARBOLEDA DUQUE",
    "DAVID ANDRES MORALES GUAPACHA",
    "DAVID STIVEN OCAMPO LONDOÑO",
    "ESTEBAN REYES AGUDELO",
    "JACOBO GALVIS JIMENEZ",
    "JAIME ANDRES CALLE SALAZAR",
    "JEFERSON MAURICIO HERNANDEZ LADINO",
    "JHON ALEXANDER PINEDA OSORIO",
    "JOSE MIGUEL SIERRA ARISTIZABAL",
    "JOSÉ SEBASTIÁN OCAMPO LÓPEZ",
    "JUAN ANDRES OSORIO GOMEZ",
    "JUAN DIEGO CALVO OSORIO",
    "JUAN ESTEBAN LOPEZ CALLE",
    "JUAN PABLO RIOS ARISTIZABAL",
    "MARIA PAULA MELO SOLANO",
    "MIGUEL ANGEL PEÑA JIMENEZ",
    "SAMUEL CASTAÑO CARDONA",
    "JUAN JOSÉ POSADA PÉREZ",
    "ALEJANDRO SERNA LONDOÑO",
    "JUAN MANUEL ZULUAGA RINCON",
    "JUAN DANIEL GOMEZ LASERNA",
    "YERSON STIVEN HERRERA OBANDO",
    "MATEO HERRERA VARGAS",
    "ALEJANDRO VALLEJO ESCOBAR",
  ];

  print("Datos de prueba cargados correctamente.");
}

String leerCadena(String mensaje) {
  print(mensaje);
  String? input = stdin.readLineSync();
  while (input == null || input.isEmpty) {
    print("Entrada no válida. Inténtelo de nuevo.");
    input = stdin.readLineSync();
  }
  return input;
}

int leerEntero(String mensaje) {
  while (true) {
    print(mensaje);
    try {
      String? input = stdin.readLineSync();
      if (input != null && input.isNotEmpty) {
        return int.parse(input);
      }
    } catch (e) {
      print("Entrada no válida. Ingrese un número entero.");
    }
  }
}
