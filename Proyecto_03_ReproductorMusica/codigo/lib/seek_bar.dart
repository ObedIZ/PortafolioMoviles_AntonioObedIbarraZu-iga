import 'package:flutter/material.dart';

/// Widget personalizado de tipo StatelessWidget encargado  de pintar controlar la barra deslizante (Slider)
class SeekBar extends StatelessWidget {
  // Parámetros obligatorios que debe recibir de la pantalla principal para poder dibujarse
  final Duration duration;         // Duración total de la canción actual
  final Duration position;         // Segundo exacto por el que va la reproducción
  final Duration bufferedPosition; // Tiempo de audio descargado en segundo plano
  
  /// Función que se ejecuta para notificar al reproductor que la posición del Slider ha cambiado.
  final ValueChanged<Duration>? onChangeEnd;

  const SeekBar({
    super.key, 
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChangeEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          activeColor: Colors.yellow,   
          inactiveColor: Colors.grey,   
          min: 0.0,
          
          // El Slider trabaja con números decimales (double). Convertimos la duración total a milisegundos.
          max: duration.inMilliseconds.toDouble(),
          
          // Posición actual del indicador amarillo en milisegundos.
          // El método .clamp() es un seguro: evita que el indicador intente salirse de los límites de la canción.
          value: position.inMilliseconds.toDouble().clamp(
            0.0,
            duration.inMilliseconds.toDouble(),
          ),
          
          // Se activa inmediatamente mientras el usuario arrastra el dedo por la barra
          onChanged: (value) {
            // Convierte el valor decimal del Slider a milisegundos enteros redondeados,
            // lo empaqueta en un objeto Duration y dispara la función para mover el audio en tiempo real.
            onChangeEnd?.call(Duration(milliseconds: value.round()));
          },
        ),
        
        Row(
          // Distribuye los elementos empujando uno al extremo izquierdo y el otro al derecho
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Texto izquierdo: Muestra el tiempo transcurrido formateado (ej. 01:23)
            Text(
              _formatDuration(position),
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              _formatDuration(duration),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  /// Función matemática interna encargada de transformar los milisegundos crudos en una cadena de texto limpia
  String _formatDuration(Duration duration) {
    // Agrega un cero a la izquierda si el número es menor a 10 (ej. transforma '5' en '05')
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    
    // Obtiene los minutos e ignora las horas usando el residuo matemático
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    // Obtiene los segundos e ignora los minutos
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    
    // Retorna el texto final con el formato clásico de minutero
    return '$minutes:$seconds';
  }
}