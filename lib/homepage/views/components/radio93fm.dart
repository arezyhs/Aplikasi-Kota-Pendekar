// ignore_for_file: avoid_print, deprecated_member_use, prefer_const_constructors, unused_element, sized_box_for_whitespace, prefer_typing_uninitialized_variables, constant_identifier_names, must_call_super, unused_local_variable, non_constant_identifier_names, use_key_in_widget_constructors, unused_field

import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    // Stop playback and dispose player here (owner of player)
    try {
      player.stop();
    } catch (_) {}
    player.dispose();
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
    // Preload stream so player is ready, but do NOT auto-play.
    preloadAudio();
    // Note: audio should be user-initiated on Home to avoid unexpected playback
    // and lifecycle issues. The user taps play to start.
    initAudioSession();

    // Note: Do NOT modify system UI (status/navigation bars) here so the
    // app's system navigation remains consistent across tabs. Previous
    // behavior hid the navigation bar on Home which made other screens show
    // different system UI. Keep orientation and system UI decisions at the
    // app/shell level instead.

    // Mengecek status siaran langsung setiap 30 detik
  }

  @override
  bool get wantKeepAlive => true;

  // Implementasi fungsi fetchDataFromFirebase untuk mengambil data dari Firebase

  Future<void> preloadAudio() async {
    await player.setUrl(url);
  }

  Future<void> playAudio() async {
    if (!mounted) return;
    if (!_isAudioPlaying) {
      try {
        await player.setUrl(url, preload: true);
        await player.play();
        if (!mounted) return;
        setState(() {
          _isAudioPlaying = true;
        });
      } catch (e) {
        // ignore errors if widget disposed or player closed
        debugPrint('playAudio error: $e');
      }
    }
  }

  void stopAudio() {
    if (_isAudioPlaying) {
      // Periksa apakah audio sedang diputar
      player.stop();
      if (mounted) {
        setState(() {
          _isAudioPlaying = false; // Atur status pemutaran audio menjadi false
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
  const AudioPlayerWidget({
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
  // subscription to player state stream so we can cancel on dispose
  StreamSubscription? _playerStateSub;

  @override
  void dispose() {
    // Do not dispose widget.player here; the parent owns it.
    // Cancel any subscriptions if they exist (handled below).
    _playerStateSub?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Listen to player state and update only while mounted. Keep subscription
    // so it can be cancelled in dispose.
    _playerStateSub = widget.player.playerStateStream.listen((playerState) {
      if (!mounted) return;
      if (playerState.processingState == ProcessingState.completed ||
          playerState.processingState == ProcessingState.idle) {
        setState(() {
          _isPlaying = false;
        });
      } else if (playerState.processingState == ProcessingState.ready ||
          playerState.processingState == ProcessingState.buffering) {
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
    // Parent padding is provided by HomeScreen; avoid extra horizontal margin
    return Container(
      margin: EdgeInsets.zero,
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
          child: SizedBox(
            height: 120,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/images/bannerlppl.png'),
                  fit: BoxFit.fitWidth,
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
                          height: 96,
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
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                              child: _isPlaying
                                  ? Image.asset('assets/images/pause.png',
                                      key: const ValueKey("pause"),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover)
                                  : Image.asset('assets/images/play.png',
                                      key: const ValueKey("play"),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover),
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
      ),
    );
  }
}
