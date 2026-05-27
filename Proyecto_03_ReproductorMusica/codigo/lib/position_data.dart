/// Clase de soporte (Modelo de datos) para el reproductor de música.
/// Su propósito es agrupar las tres variables de tiempo para que la interfaz pueda leerlas en un solo paquete.
class PositionData {
  /// Almacena el segundo exacto por el que va reproduciéndose la canción en tiempo real.
  final Duration position;

  /// Almacena el tiempo de audio que ya se encuentra descargado o precargado en la memoria 
  final Duration bufferedPosition;

  /// Almacena la duración total que tiene el archivo de audio completo.
  final Duration duration;

  /// Constructor de la clase. Permite crear el objeto y rellenar los tres datos al mismo tiempo en una sola instrucción.
  PositionData(this.position, this.bufferedPosition, this.duration);
}