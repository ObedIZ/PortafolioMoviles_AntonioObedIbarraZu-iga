import 'package:flutter/material.dart';
import 'music_player_screen.dart';

/// Funciona como el "botón de encendido" del proyecto.
void main(){
  // runApp toma el widget principal y lo despliega a lo largo de la pantalla
  runApp(const MusicPlayerApp());
}

/// Widget raíz de la aplicación (Stateless porque su configuración es fija).
/// Aquí se definen los ajustes globales y el estilo base del proyecto.
class MusicPlayerApp extends StatelessWidget {
  const MusicPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp inicializa las herramientas de diseño basadas en Material Design de Google
    return const MaterialApp(
      // Oculta la molesta etiqueta roja que dice "DEBUG" en la esquina superior derecha
      debugShowCheckedModeBanner: false,
      
      // Título interno del proyecto (el que reconoce el sistema operativo del teléfono)
      title: 'Music Player',
      
      // Define cuál será la primera vista que se cargará al abrir la app.
      // Aquí se manda a llamar a nuestra pantalla del reproductor.
      home: MusicPlayerScreen(),
    );
  } 
}