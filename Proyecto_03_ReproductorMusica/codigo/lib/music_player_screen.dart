import 'dart:ui'; 
import 'package:aplicacion/seek_bar.dart';
import 'package:aplicacion/position_data.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  
  // 1. Índice para saber qué canción está sonando (0 es la primera, 1 la segunda)
  int _currentIndex = 0;

  // 2. Definimos la lista de canciones con su título y su archivo de audio
  final List<Map<String, String>> _playlist = [
    {
      'title': 'Lumière',
      'artist': 'Lorien Testard',
      'url': 'assets/audio/Lumière.mp3',
    },
    {
      'title': 'For Those Who Come After',
      'artist': 'Lorien Testard',
      'url': 'assets/audio/For-Those-Who-Come-After.mp3',
    },
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _loadAudio();
  }

 // 3. Cargar la canción actual basándose en el índice
  Future<void> _loadAudio() async {
    try {
      // Detener cualquier reproducción previa para limpiar el buffer de audio
      await _audioPlayer.stop(); 
      
      // Cargar el nuevo recurso físico
      await _audioPlayer.setAsset(_playlist[_currentIndex]['url']!);
      
      // Si la app ya estaba en estado "Play", forzar a reproducir la nueva pista de inmediato
      if (isPlaying) {
        await _audioPlayer.play(); 
      }
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  // 4. Funciones para los botones laterales (Cambiar de pista)
  void _nextTrack() {
    if (_currentIndex < _playlist.length - 1) {
      _currentIndex++; // Avanza a la siguiente
    } else {
      _currentIndex = 0; // Si es la última, regresa a la primera
    }
    _loadAudio();
    setState(() {});
  }

  void _previousTrack() {
    if (_currentIndex > 0) {
      _currentIndex--; // Retrocede a la anterior
    } else {
      _currentIndex = _playlist.length - 1; // Si es la primera, va a la última
    }
    _loadAudio();
    setState(() {});
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream.map(
          (duration) => duration ?? Duration.zero,
        ),
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration!),
      );

  void _playPause() {
    if (isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1C1A),
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        title: const Text('Hearme', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0), 
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Cover.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.55), 
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                children: [
                  Center(
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          )
                        ],
                        image: const DecorationImage(
                          image: AssetImage('assets/images/Cover.jpg'), // Sigue usando el mismo cover fija
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      // 5. El texto ahora cambia según la canción seleccionada
                      Text(
                        _playlist[_currentIndex]['title']!,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _playlist[_currentIndex]['artist']!,
                        style: const TextStyle(
                          fontSize: 18, 
                          color: Colors.white70,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  StreamBuilder<PositionData>(
                    stream: _positionDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return SeekBar(
                        duration: positionData?.duration ?? Duration.zero,
                        position: positionData?.position ?? Duration.zero,
                        bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
                        onChangeEnd: (newPosition) {
                          _audioPlayer.seek(newPosition);
                        },
                      );
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 6. Conectamos el botón de ANTERIOR
                      IconButton(
                        iconSize: 48,
                        icon: const Icon(Icons.skip_previous, color: Colors.white),
                        onPressed: _previousTrack, 
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        iconSize: 76, 
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                          color: Colors.white,
                        ),
                        onPressed: _playPause,
                      ),
                      const SizedBox(width: 16),
                      // 7. Conectamos el botón de SIGUIENTE
                      IconButton(
                        iconSize: 48,
                        icon: const Icon(Icons.skip_next, color: Colors.white),
                        onPressed: _nextTrack, 
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}