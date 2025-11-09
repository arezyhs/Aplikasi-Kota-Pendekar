// ignore_for_file: avoid_print, deprecated_member_use, prefer_const_constructors, unused_element, sized_box_for_whitespace, prefer_typing_uninitialized_variables, constant_identifier_names, must_call_super, unused_local_variable, non_constant_identifier_names, use_key_in_widget_constructors, unused_field

import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class HomePlayer extends StatefulWidget {
  @override
  _HomePlayerState createState() => _HomePlayerState();
}

class _HomePlayerState extends State<HomePlayer>
    with AutomaticKeepAliveClientMixin {
  static const int MAX_SAMPLES = 44100; // Ubah nilai sesuai kebutuhan Anda

  static String url = "https://play-93fm.madiunkota.go.id/live";

  late AudioSession session;

  List<double> audioSamples = []; // Data sampel audio

  var duration;

  final player = AudioPlayer();

  bool _isAudioPlaying = false;
  late Timer _timer;

  @override
  void dispose() {
    player.dispose();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // Show the system status bar
    _timer.cancel(); // Menghentikan timer

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // Show the system status bar
    _timer.cancel(); // Menghentikan timer

    super.dispose();
  }

  Future<void> initAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playback,
      avAudioSessionMode: AVAudioSessionMode.defaultMode,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.mixWithOthers,
    ));
  }

  @override
  void initState() {
    super.initState();
    preloadAudio();
    playAudio();

    initAudioSession();

    // Mengunci orientasi layar ke mode potret
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]); // Show only the status bar

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]); // Show only the status bar

    // Mengecek status siaran langsung setiap 30 detik
  }

  @override
  bool get wantKeepAlive => true;

  // Implementasi fungsi fetchDataFromFirebase untuk mengambil data dari Firebase

  Future<void> preloadAudio() async {
    await player.setUrl(url);
  }

  Future<void> playAudio() async {
    if (!_isAudioPlaying) {
      await player.setUrl(url, preload: true);
      await player.play();
      setState(() {
        _isAudioPlaying = true;
      });
    }
  }

  void stopAudio() {
    if (_isAudioPlaying) {
      // Periksa apakah audio sedang diputar
      player.stop();
      setState(() {
        _isAudioPlaying = false; // Atur status pemutaran audio menjadi false
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AudioPlayerWidget(
      player: player,
      audioSamples: audioSamples,

      isPlaying:
          _isAudioPlaying, // Pass the audio playing status to AudioPlayerWidget
      playAudio: playAudio, // Pass the playAudio method to AudioPlayerWidget
      stopAudio: stopAudio, // Pass the stopAudio method to AudioPlayerWidget
    );
  }
}

class AudioPlayerWidget extends StatefulWidget {
  AudioPlayerWidget({
    Key? key,
    required this.player,
    required this.audioSamples,
    required this.isPlaying,
    required this.playAudio,
    required this.stopAudio,
  }) : super(key: key);

  final List<double> audioSamples;
  final bool isPlaying; // Tambahkan properti untuk status pemutaran audio
  final VoidCallback playAudio; // Tambahkan properti untuk metode playAudio
  final AudioPlayer player;
  final VoidCallback stopAudio; // Tambahkan properti untuk metode stopAudio

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  bool _isPlaying = false;

  @override
  void dispose() {
    widget.player.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    widget.player.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed ||
          playerState.processingState == ProcessingState.idle) {
        setState(() {
          _isPlaying = false;
        });
      } else if (playerState.processingState == ProcessingState.ready ||
          playerState.processingState == ProcessingState.buffering ||
          playerState.processingState == ProcessingState.ready) {
        setState(() {
          _isPlaying = true;
        });
      }
    });
  }

  void _togglePlayback() async {
    if (_isPlaying) {
      widget.stopAudio(); // Stop audio if it's playing
      setState(() {
        _isPlaying = false; // Update playback status
      });
    } else {
      widget.playAudio(); // Start audio if it's not playing
      setState(() {
        _isPlaying = true; // Update playback status
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
      ),  
      child: GestureDetector(
        onTap: () {
          if (_isPlaying) {
            widget.player.stop(); // Stop audio if it's playing
          } else {
            widget.player.play(); // Start audio if it's not playing
          }
        },
        child: Card(
          elevation: 2,
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/bannerlppl.png'), // Ganti dengan path gambar pattern Anda
                fit: BoxFit.fill,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.zero,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: size.height * 0.1,
                        child: MaterialButton(
                          onPressed: () {
                            if (_isPlaying) {
                              widget.player
                                  .stop(); // Stop audio if it's playing
                            } else {
                              widget.player
                                  .play(); // Start audio if it's not playing
                            }
                          },
                          highlightColor:
                              Colors.transparent, // Menghilangkan highlight
                          splashColor: Colors.transparent,
                          child: Container(
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                              child: _isPlaying
                                  ? Image.asset(
                                      'assets/images/pause.png', // Path ke ikon custom
                                      key: ValueKey("pause"),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover)
                                  : Image.asset(
                                      'assets/images/play.png', // Path ke ikon custom
                                      key: ValueKey("play"),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
